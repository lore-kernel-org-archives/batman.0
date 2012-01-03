Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Tue, 3 Jan 2012 12:55:58 +0100
References: <1324642552-23038-1-git-send-email-sven@narfation.org>
In-Reply-To: <1324642552-23038-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201201031255.59342.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/3] batmand: Remove unmaintained *BSD
	port
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Applied, thanks!

Cheers,
Elektra

Am Freitag, 23. Dezember 2011 13:15:50 schrieb Sven Eckelmann:
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  INSTALL        |    9 +-
>  Makefile       |   18 ----
>  bsd/compat.c   |   53 -------------
>  bsd/kernel.c   |  145 ----------------------------------
>  bsd/route.c    |  224 ----------------------------------------------------
>  bsd/tun.c      |  239 --------------------------------------------------------
>  list-batman.h  |    7 --
>  posix/tunnel.c |   15 ----
>  8 files changed, 4 insertions(+), 706 deletions(-)
>  delete mode 100644 bsd/compat.c
>  delete mode 100644 bsd/kernel.c
>  delete mode 100644 bsd/route.c
>  delete mode 100644 bsd/tun.c
> 
> diff --git a/INSTALL b/INSTALL
> index 41566ab..15f53b0 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -13,12 +13,11 @@ You need the usual compile environment and the libpthread-library
>  and the kernel module "tun". Both should already be installed on
>  your machine, if you use a PC with Linux. On embedded devices
>  both may not be installed in order to save space. GNU Make is needed
> -for compilation (currently BSD Make is not cooperating).
> +for compilation.
>  
> -The *BSD and Mac OS operating systems are currently unmaintained,
> -make targets are still available but will most probably not work.
> -If you're interested in porting and maintaining B.A.T.M.A.N. for
> -these systems, please contact us. We would appreciate your help.
> +The ports to *BSD and Mac OS operating systems are currently not
> +available. If you're interested in porting and maintaining B.A.T.M.A.N.
> +for these systems, please contact us. We would appreciate your help.
>  
>  Tweaking
>  --------
> diff --git a/Makefile b/Makefile
> index 65e0cf2..9aafbc8 100755
> --- a/Makefile
> +++ b/Makefile
> @@ -23,30 +23,12 @@ BINARY_NAME = batmand
>  
>  UNAME =		$(shell uname)
>  POSIX_OBJ =	posix/init.o posix/posix.o posix/tunnel.o posix/unix_socket.o
> -BSD_OBJ =	bsd/route.o bsd/tun.o bsd/kernel.o bsd/compat.o
>  LINUX_OBJ =	linux/route.o linux/tun.o linux/kernel.o
>  
>  ifeq ($(UNAME),Linux)
>  OS_OBJ =	$(LINUX_OBJ) $(POSIX_OBJ)
>  endif
>  
> -ifeq ($(UNAME),Darwin)
> -OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
> -endif
> -
> -ifeq ($(UNAME),GNU/kFreeBSD)
> -OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
> -LDLIBS +=	-lfreebsd -lbsd
> -endif
> -
> -ifeq ($(UNAME),FreeBSD)
> -OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
> -endif
> -
> -ifeq ($(UNAME),OpenBSD)
> -OS_OBJ =	$(BSD_OBJ) $(POSIX_OBJ)
> -endif
> -
>  OBJ = batman.o originator.o schedule.o list-batman.o allocate.o bitarray.o hash.o profile.o ring_buffer.o hna.o $(OS_OBJ)
>  MANPAGE = man/batmand.8
>  
> diff --git a/bsd/compat.c b/bsd/compat.c
> deleted file mode 100644
> index a628378..0000000
> --- a/bsd/compat.c
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -/*
> - * Copyright (C) 2006, 2007 BATMAN contributors:
> - * Stefan Sperling <stsp@stsp.name>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA
> - *
> - */
> -
> -/* This file contains functions that are used by batman but are not
> - * present in BSD libc. */
> -
> -#warning BSD support is known broken - if you compile this on BSD you are expected to fix it :-P
> -
> -#include <sys/types.h>
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <stdarg.h>
> -
> -/* Adapted from busybox */
> -int vdprintf(int d, const char *format, va_list ap)
> -{
> -	char buf[1024];
> -	int len;
> -
> -	len = vsnprintf(buf, sizeof(buf), format, ap);
> -	return write(d, buf, len);
> -}
> -
> -/* From glibc */
> -int dprintf(int d, const char *format, ...)
> -{
> -  va_list arg;
> -  int done;
> -
> -  va_start (arg, format);
> -  done = vdprintf (d, format, arg);
> -  va_end (arg);
> -
> -  return done;
> -}
> -
> diff --git a/bsd/kernel.c b/bsd/kernel.c
> deleted file mode 100644
> index b98c06f..0000000
> --- a/bsd/kernel.c
> +++ /dev/null
> @@ -1,145 +0,0 @@
> -/*
> - * Copyright (C) 2006, 2007 BATMAN contributors:
> - * Stefan Sperling <stsp@stsp.name>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA
> - *
> - */
> -
> -/* This file contains functions that deal with BSD kernel interfaces,
> - * such as sysctls. */
> -
> -#warning BSD support is known broken - if you compile this on BSD you are expected to fix it :-P
> -
> -#include <sys/types.h>
> -#include <sys/param.h>
> -#include <sys/sysctl.h>
> -#include <sys/socket.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <err.h>
> -
> -#include "../os.h"
> -#include "../batman.h"
> -
> -void set_forwarding(int32_t state)
> -{
> -	int mib[4];
> -
> -	/* FreeBSD allows us to set a boolean sysctl to anything.
> -	 * Check the value for sanity. */
> -	if (state < 0 || state > 1) {
> -		errno = EINVAL;
> -		err(1, "set_forwarding: %i", state);
> -	}
> -
> -	/* "net.inet.ip.forwarding" */
> -	mib[0] = CTL_NET;
> -	mib[1] = PF_INET;
> -	mib[2] = IPPROTO_IP;
> -	mib[3] = IPCTL_FORWARDING;
> -
> -	if (sysctl(mib, 4, NULL, 0, (void*)&state, sizeof(state)) == -1)
> -		err(1, "Cannot change net.inet.ip.forwarding");
> -}
> -
> -int32_t get_forwarding(void)
> -{
> -	int state;
> -	size_t len;
> -	int mib[4];
> -
> -	/* "net.inet.ip.forwarding" */
> -	mib[0] = CTL_NET;
> -	mib[1] = PF_INET;
> -	mib[2] = IPPROTO_IP;
> -	mib[3] = IPCTL_FORWARDING;
> -
> -	len = sizeof(state);
> -
> -	if (sysctl(mib, 4, &state, &len, NULL, 0) == -1)
> -		err(1, "Cannot tell if packet forwarding is enabled");
> -
> -	return state;
> -}
> -
> -void set_send_redirects(int32_t state, char* BATMANUNUSED(dev))
> -{
> -	int mib[4];
> -
> -	/* FreeBSD allows us to set a boolean sysctl to anything.
> -	 * Check the value for sanity. */
> -	if (state < 0 || state > 1) {
> -		errno = EINVAL;
> -		err(1, "set_send_redirects: %i", state);
> -	}
> -
> -	/* "net.inet.ip.redirect" */
> -	mib[0] = CTL_NET;
> -	mib[1] = PF_INET;
> -	mib[2] = IPPROTO_IP;
> -	mib[3] = IPCTL_SENDREDIRECTS;
> -
> -	if (sysctl(mib, 4, NULL, 0, (void*)&state, sizeof(state)) == -1)
> -		err(1, "Cannot change net.inet.ip.redirect");
> -}
> -
> -int32_t get_send_redirects(char *BATMANUNUSED(dev))
> -{
> -	int state;
> -	size_t len;
> -	int mib[4];
> -
> -	/* "net.inet.ip.redirect" */
> -	mib[0] = CTL_NET;
> -	mib[1] = PF_INET;
> -	mib[2] = IPPROTO_IP;
> -	mib[3] = IPCTL_SENDREDIRECTS;
> -
> -	len = sizeof(state);
> -
> -	if (sysctl(mib, 4, &state, &len, NULL, 0) == -1)
> -		err(1, "Cannot tell if redirects are enabled");
> -
> -	return state;
> -}
> -
> -void set_rp_filter( int32_t BATMANUNUSED(state), char* BATMANUNUSED(dev) )
> -{
> -	/* On BSD, reverse path filtering should be disabled in the firewall. */
> -	return;
> -}
> -
> -int32_t get_rp_filter( char *BATMANUNUSED(dev) )
> -{
> -	/* On BSD, reverse path filtering should be disabled in the firewall. */
> -	return 0;
> -}
> -
> -
> -int8_t bind_to_iface( int32_t BATMANUNUSED(udp_recv_sock), char *BATMANUNUSED(dev) )
> -{
> -	/* XXX: Is binding a socket to a specific
> -	 * interface possible in *BSD?
> -	 * Possibly via bpf... */
> -	return 1;
> -}
> -
> -int32_t use_gateway_module(void)
> -{
> -	return -1;
> -}
> -
> diff --git a/bsd/route.c b/bsd/route.c
> deleted file mode 100644
> index 8c9de48..0000000
> --- a/bsd/route.c
> +++ /dev/null
> @@ -1,224 +0,0 @@
> -/*
> - * Copyright (C) 2006, 2007 BATMAN contributors:
> - * Stefan Sperling <stsp@stsp.name>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA
> - *
> - */
> -
> -/* This file contains interface functions for the routing table on BSD. */
> -
> -#warning BSD support is known broken - if you compile this on BSD you are expected to fix it :-P
> -
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <sys/ioctl.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <net/route.h>
> -#include <net/if.h>
> -#include <stdio.h>
> -#include <string.h>
> -#include <errno.h>
> -#include <unistd.h>
> -#include <err.h>
> -
> -#include "../os.h"
> -#include "../batman.h"
> -
> -/* Message structure used to interface the kernel routing table.
> - * See route(4) for details on the message passing interface for
> - * manipulating the kernel routing table.
> - */
> -struct rt_msg
> -{
> -	struct rt_msghdr hdr;
> -	struct sockaddr_in dest;
> -	struct sockaddr_in gateway;
> -	struct sockaddr_in netmask;
> -};
> -
> -static inline int32_t n_bits(uint8_t n)
> -{
> -	int32_t i, result;
> -
> -	result = 0;
> -
> -	if (n > 32)
> -		n = 32;
> -	for (i = 0; i < n; i++)
> -		result |= (0x80000000 >> i);
> -
> -	return result;
> -}
> -
> -/* Send routing message msg to the kernel.
> - * The kernel's reply is returned in msg. */
> -static int rt_message(struct rt_msg *msg)
> -{
> -	int rt_sock;
> -	static unsigned int seq = 0;
> -	ssize_t len;
> -	pid_t pid;
> -
> -	rt_sock = socket(PF_ROUTE, SOCK_RAW, AF_INET);
> -	if (rt_sock < 0)
> -		err(1, "Could not open socket to routing table");
> -
> -	pid = getpid();
> -	len = 0;
> -	seq++;
> -
> -	/* Send message */
> -	do {
> -		msg->hdr.rtm_seq = seq;
> -		len = write(rt_sock, msg, msg->hdr.rtm_msglen);
> -		if (len < 0) {
> -			warn("Error sending routing message to kernel");
> -			return -1;
> -		}
> -	} while (len < msg->hdr.rtm_msglen);
> -
> -	/* Get reply */
> -	do {
> -		len = read(rt_sock, msg, sizeof(struct rt_msg));
> -		if (len < 0)
> -			err(1, "Error reading from routing socket");
> -	} while (len > 0 && (msg->hdr.rtm_seq != seq
> -				|| msg->hdr.rtm_pid != pid));
> -
> -	if (msg->hdr.rtm_version != RTM_VERSION)
> -		warn("RTM_VERSION mismatch: compiled with version %i, "
> -		    "but running kernel uses version %i", RTM_VERSION,
> -		    msg->hdr.rtm_version);
> -
> -	/* Check reply for errors. */
> -	if (msg->hdr.rtm_errno) {
> -		errno = msg->hdr.rtm_errno;
> -		return -1;
> -	}
> -
> -	return 0;
> -}
> -
> -/* Get IP address of a network device (e.g. "tun0"). */
> -static uint32_t get_dev_addr(char *dev)
> -{
> -	int so;
> -	struct ifreq ifr;
> -	struct sockaddr_in *addr;
> -
> -	memset(&ifr, 0, sizeof(ifr));
> -
> -	strlcpy(ifr.ifr_name, dev, IFNAMSIZ);
> -
> -	so = socket(AF_INET, SOCK_DGRAM, 0);
> -	if (ioctl(so, SIOCGIFADDR, &ifr, sizeof(ifr)) < 0) {
> -		perror("SIOCGIFADDR");
> -		return -1;
> -	}
> -
> -	if (ifr.ifr_addr.sa_family != AF_INET) {
> -		warn("get_dev_addr: got a non-IPv4 interface");
> -		return -1;
> -	}
> -
> -	addr = (struct sockaddr_in*)&ifr.ifr_addr;
> -	return addr->sin_addr.s_addr;
> -}
> -
> -void add_del_route(uint32_t dest, uint8_t netmask, uint32_t router, uint32_t BATMANUNUSED(src_ip),
> -		int32_t BATMANUNUSED(ifi), char *dev, uint8_t BATMANUNUSED(rt_table), int8_t BATMANUNUSED(route_type), int8_t del)
> -{
> -	char dest_str[16], router_str[16];
> -	struct rt_msg msg;
> -
> -	memset(&msg, 0, sizeof(struct rt_msg));
> -
> -	inet_ntop(AF_INET, &dest, dest_str, sizeof (dest_str));
> -	inet_ntop(AF_INET, &router, router_str, sizeof (router_str));
> -
> -	/* Message header */
> -	msg.hdr.rtm_type = del ? RTM_DELETE : RTM_ADD;
> -	msg.hdr.rtm_version = RTM_VERSION;
> -	msg.hdr.rtm_flags = RTF_STATIC | RTF_UP;
> -	if (netmask == 32)
> -		msg.hdr.rtm_flags |= RTF_HOST;
> -	msg.hdr.rtm_addrs = RTA_DST | RTA_GATEWAY | RTA_NETMASK;
> -	msg.hdr.rtm_msglen = sizeof(struct rt_msg);
> -
> -	/* Destination and gateway sockaddrs */
> -	msg.dest.sin_family = AF_INET;
> -	msg.dest.sin_len = sizeof(struct sockaddr_in);
> -	msg.gateway.sin_family = AF_INET;
> -	msg.gateway.sin_len = sizeof(struct sockaddr_in);
> -	msg.hdr.rtm_flags = RTF_GATEWAY;
> -	if (dest == router) {
> -		if (dest == 0) {
> -			/* Add default route via dev */
> -			fprintf(stderr, "%s default route via %s\n",
> -				del ? "Deleting" : "Adding", dev);
> -			msg.gateway.sin_addr.s_addr = get_dev_addr(dev);
> -		} else {
> -			/* Route to dest via default route.
> -			 * This is a nop. */
> -			return;
> -		}
> -	} else {
> -		if (router != 0) {
> -			/* Add route to dest via router */
> -			msg.dest.sin_addr.s_addr = dest;
> -			msg.gateway.sin_addr.s_addr = router;
> -			fprintf(stderr, "%s route to %s/%i via %s\n", del ? "Deleting" : "Adding",
> -					dest_str, netmask, router_str);
> -		} else {
> -			/* Route to dest via default route.
> -			 * This is a nop. */
> -			return;
> -		}
> -	}
> -
> -	/* Netmask sockaddr */
> -	msg.netmask.sin_family = AF_INET;
> -	msg.netmask.sin_len = sizeof(struct sockaddr_in);
> -	/* Netmask is passed as decimal value (e.g. 28 for a /28).
> -	 * So we need to convert it into a bit pattern with n_bits(). */
> -	msg.netmask.sin_addr.s_addr = htonl(n_bits(netmask));
> -
> -	if (rt_message(&msg) < 0)
> -		err(1, "Cannot %s route to %s/%i",
> -			del ? "delete" : "add", dest_str, netmask);
> -}
> -
> -
> -void add_del_rule(uint32_t BATMANUNUSED(network), uint8_t BATMANUNUSED(netmask), int8_t BATMANUNUSED(rt_table),
> -		uint32_t BATMANUNUSED(prio), char *BATMANUNUSED(iif), int8_t BATMANUNUSED(dst_rule), int8_t BATMANUNUSED(del) )
> -{
> -	fprintf(stderr, "add_del_rule: not implemented\n");
> -	return;
> -}
> -
> -int add_del_interface_rules( int8_t BATMANUNUSED(del) )
> -{
> -	fprintf(stderr, "add_del_interface_rules: not implemented\n");
> -	return 0;
> -}
> -
> -int flush_routes_rules( int8_t BATMANUNUSED(rt_table) )
> -{
> -	fprintf(stderr, "flush_routes_rules: not implemented\n");
> -	return 0;
> -}
> -
> diff --git a/bsd/tun.c b/bsd/tun.c
> deleted file mode 100644
> index 2c571c0..0000000
> --- a/bsd/tun.c
> +++ /dev/null
> @@ -1,239 +0,0 @@
> -/*
> - * Copyright (C) 2006, 2007 BATMAN contributors:
> - * Stefan Sperling <stsp@stsp.name>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA
> - *
> - */
> -
> -/* This file contains functions interfacing tun devices on BSD. */
> -
> -#warning BSD support is known broken - if you compile this on BSD you are expected to fix it :-P
> -
> -#include <sys/types.h>
> -#include <sys/socket.h>
> -#include <sys/ioctl.h>
> -#include <sys/stat.h>
> -#include <netinet/in.h>
> -#include <arpa/inet.h>
> -#include <net/if.h>
> -#include <net/if_tun.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include <err.h>
> -
> -#include "../os.h"
> -#include "../batman.h"
> -
> -
> -/*
> - * open_tun_any() opens an available tun device.
> - * It returns the file descriptor as return value,
> - * or -1 on failure.
> - *
> - * The human readable name of the device (e.g. "/dev/tun0") is
> - * copied into the dev_name parameter. The buffer to hold
> - * this string is assumed to be dev_name_size bytes large.
> - */
> -#if defined(__OpenBSD__) || defined(__Darwin__)
> -static int open_tun_any(char *dev_name, size_t dev_name_size)
> -{
> -	int i;
> -	int fd;
> -	char tun_dev_name[12]; /* 12 = length("/dev/tunxxx\0") */
> -
> -	for (i = 0; i < sizeof(tun_dev_name); i++)
> -		tun_dev_name[i] = '\0';
> -
> -	/* Try opening tun device /dev/tun[0..255] */
> -	for (i = 0; i < 256; i++) {
> -		snprintf(tun_dev_name, sizeof(tun_dev_name), "/dev/tun%i", i);
> -		if ((fd = open(tun_dev_name, O_RDWR)) != -1) {
> -			if (dev_name != NULL)
> -				strlcpy(dev_name, tun_dev_name, dev_name_size);
> -			return fd;
> -		}
> -	}
> -	return -1;
> -}
> -#elif defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> -static int open_tun_any(char *dev_name, size_t dev_name_size)
> -{
> -	int fd;
> -	struct stat buf;
> -
> -	/* Open lowest unused tun device */
> -	if ((fd = open("/dev/tun", O_RDWR)) != -1) {
> -		fstat(fd, &buf);
> -		printf("Using %s\n", devname(buf.st_rdev, S_IFCHR));
> -		if (dev_name != NULL)
> -			strlcpy(dev_name, devname(buf.st_rdev, S_IFCHR), dev_name_size);
> -		return fd;
> -	}
> -	return -1;
> -}
> -#endif
> -
> -/* Probe for nat tool availability */
> -int probe_nat_tool(void) {
> -	fprintf(stderr, "probe_nat_tool: not implemented\n");
> -	return -1;
> -}
> -
> -void add_nat_rule(char *BATMANUNUSED(dev)) {
> -	fprintf(stderr, "add_nat_rule: not implemented\n");
> -}
> -
> -void del_nat_rule(char *BATMANUNUSED(dev)) {
> -	fprintf(stderr, "del_nat_rule: not implemented\n");
> -}
> -
> -void own_hna_rules(uint32_t hna_ip, uint8_t netmask, int8_t route_action) {
> -	fprintf(stderr, "own_hna_rules: not implemented\n");
> -}
> -
> -/* Probe for tun interface availability */
> -int8_t probe_tun(uint8_t BATMANUNUSED(print_to_stderr))
> -{
> -	int fd;
> -	fd = open_tun_any(NULL, 0);
> -	if (fd == -1)
> -		return 0;
> -	close(fd);
> -	return 1;
> -}
> -
> -int8_t del_dev_tun(int32_t fd)
> -{
> -	return close(fd);
> -}
> -
> -int8_t set_tun_addr(int32_t BATMANUNUSED(fd), uint32_t tun_addr, char *tun_ifname)
> -{
> -	int so;
> -	struct ifreq ifr_tun;
> -	struct sockaddr_in *addr;
> -
> -	memset(&ifr_tun, 0, sizeof(ifr_tun));
> -	strlcpy(ifr_tun.ifr_name, tun_ifname, IFNAMSIZ);
> -
> -	so = socket(AF_INET, SOCK_DGRAM, 0);
> -
> -	/* Get interface flags */
> -	if (ioctl(so, SIOCGIFFLAGS, &ifr_tun) < 0) {
> -		perror("SIOCGIFFLAGS");
> -		return -1;
> -	}
> -
> -	/* Set address */
> -	addr = (struct sockaddr_in*)&ifr_tun.ifr_addr;
> -	addr->sin_family = AF_INET;
> -	addr->sin_addr.s_addr = tun_addr;
> -	if (ioctl(so, SIOCAIFADDR, &ifr_tun) < 0) {
> -		perror("SIOCAIFADDR");
> -		return -1;
> -	}
> -	close(so);
> -
> -	return 0;
> -}
> -
> -int8_t add_dev_tun(struct batman_if *batman_if, uint32_t tun_addr,
> -		char *tun_dev, size_t tun_dev_size, int32_t *fd, int32_t *BATMANUNUSED(ifi))
> -{
> -	int so;
> -	struct ifreq ifr_tun, ifr_if;
> -	struct tuninfo ti;
> -	char *tun_ifname;
> -
> -	memset(&ifr_tun, 0, sizeof(ifr_tun));
> -	memset(&ifr_if, 0, sizeof(ifr_if));
> -	memset(&ti, 0, sizeof(ti));
> -
> -	if ((*fd = open_tun_any(tun_dev, tun_dev_size)) < 0) {
> -		perror("Could not open tun device");
> -		return -1;
> -	}
> -
> -	printf("Using %s\n", tun_dev);
> -
> -	/* Initialise tuninfo to defaults. */
> -	if (ioctl(*fd, TUNGIFINFO, &ti) < 0) {
> -		perror("TUNGIFINFO");
> -		del_dev_tun(*fd);
> -		return -1;
> -	}
> -
> -	/* Set name of interface to configure ("tunX") */
> -	tun_ifname = strstr(tun_dev, "tun");
> -	if (tun_ifname == NULL) {
> -		warn("Cannot determine tun interface name!");
> -		return -1;
> -	}
> -	strlcpy(ifr_tun.ifr_name, tun_ifname, IFNAMSIZ);
> -
> -	/* Open temporary socket to configure tun interface. */
> -	so = socket(AF_INET, SOCK_DGRAM, 0);
> -
> -	/* Get interface flags for tun device */
> -	if (ioctl(so, SIOCGIFFLAGS, &ifr_tun) < 0) {
> -		perror("SIOCGIFFLAGS");
> -		del_dev_tun(*fd);
> -		return -1;
> -	}
> -
> -	/* Set up and running interface flags on tun device. */
> -	ifr_tun.ifr_flags |= IFF_UP;
> -	ifr_tun.ifr_flags |= IFF_RUNNING;
> -	if (ioctl(so, SIOCSIFFLAGS, &ifr_tun) < 0) {
> -		perror("SIOCSIFFLAGS");
> -		del_dev_tun(*fd);
> -		return -1;
> -	}
> -
> -	/* Set IP of this end point of tunnel */
> -	if (set_tun_addr(*fd, tun_addr, tun_ifname) < 0) {
> -		perror("set_tun_addr");
> -		del_dev_tun(*fd);
> -		return -1;
> -	}
> -
> -	/* get MTU from real interface */
> -	strlcpy(ifr_if.ifr_name, batman_if->dev, IFNAMSIZ);
> -	if (ioctl(so, SIOCGIFMTU, &ifr_if) < 0) {
> -		perror("SIOCGIFMTU");
> -		del_dev_tun(*fd);
> -		return -1;
> -	}
> -	/* set MTU of tun interface: real MTU - 28 */
> -	if (ifr_if.ifr_mtu < 100) {
> -		fprintf(stderr, "Warning: MTU smaller than 100 - cannot reduce MTU anymore\n" );
> -	} else {
> -		ti.mtu = ifr_if.ifr_mtu - 28;
> -		if (ioctl(*fd, TUNSIFINFO, &ti) < 0) {
> -			perror("TUNSIFINFO");
> -			del_dev_tun(*fd);
> -			return -1;
> -		}
> -	}
> -
> -	strlcpy(tun_dev, ifr_tun.ifr_name, tun_dev_size);
> -	close(so);
> -	return 1;
> -}
> -
> diff --git a/list-batman.h b/list-batman.h
> index 72d2ac4..7780c9a 100644
> --- a/list-batman.h
> +++ b/list-batman.h
> @@ -26,13 +26,6 @@
>  #define _LINUX_LIST_H
>  
>  /*
> - * XXX: Resolve conflict between this file and <sys/queue.h> on BSD systems.
> - */
> -#ifdef LIST_HEAD
> -#undef LIST_HEAD
> -#endif
> -
> -/*
>   * Simple linked list implementation.
>   *
>   * Some of the internal functions ("__xxx") are useful when
> diff --git a/posix/tunnel.c b/posix/tunnel.c
> index 1cfb501..cbbdea1 100644
> --- a/posix/tunnel.c
> +++ b/posix/tunnel.c
> @@ -32,9 +32,6 @@
>  #include <netinet/ip.h>
>  #include <netinet/udp.h>
>  #include <netinet/tcp.h>
> -#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
> -#include <sys/sockio.h>
> -#endif
>  #include <net/if.h>
>  #include <fcntl.h>        /* open(), O_RDWR */
>  
> @@ -71,29 +68,17 @@ void init_bh_ports(void)
>  
>  static uint8_t get_tunneled_protocol(const unsigned char *buff)
>  {
> -#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
> -	return ((struct ip *)(buff + 1))->ip_p;
> -#else
>  	return ((struct iphdr *)(buff + 1))->protocol;
> -#endif
>  }
>  
>  static uint32_t get_tunneled_sender_ip(const unsigned char *buff)
>  {
> -#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
> -	return ((struct ip *)(buff + 1))->ip_src;
> -#else
>  	return ((struct iphdr *)(buff + 1))->saddr;
> -#endif
>  }
>  
>  static uint16_t get_tunneled_udpdest(const unsigned char *buff)
>  {
> -#if defined(__FreeBSD__) || defined(__OpenBSD__) || defined(__Darwin__)
> -       return ((struct udphdr *)(buff + 1 + ((struct ip *)(buff + 1))->ip_hl*4))->uh_dport;
> -#else
>         return ((struct udphdr *)(buff + 1 + ((struct iphdr *)(buff + 1))->ihl*4))->dest;
> -#endif
>  }
>  
>  static int8_t get_tun_ip(struct sockaddr_in *gw_addr, int32_t udp_sock, uint32_t *tun_addr)
> 


-- 
Viral meme of radical freedom

The fact that you talk in your head doesn't mean that you think.

The best way to lose control over yourself is trying to control yourself.

Most people experience themselves as a voice in their head, telling them
who they are, what they think and what they have to do.

http://en.wikipedia.org/wiki/Meme
