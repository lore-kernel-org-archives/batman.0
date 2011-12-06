Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 06 Dec 2011 16:26:36 +0100
Message-ID: <8706647.CiSi9cDazi@sven-laptop.home.narfation.org>
In-Reply-To: <4EDE241B.6040602@agblab.com>
References: <4EDDE473.5020008@agblab.com>
	<1369817.AM08eCr9Ym@sven-laptop.home.narfation.org>
	<4EDE241B.6040602@agblab.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2199464.UrB3Mcq0l2";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] TT inconsistency problem (again)
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
To: Marko Panger - AGB Lab <marko.panger@agblab.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2199464.UrB3Mcq0l2
Content-Type: multipart/mixed; boundary="nextPart1733399.ln3H7qY9c7"
Content-Transfer-Encoding: 7Bit


--nextPart1733399.ln3H7qY9c7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 06 December 2011 15:18:03 Marko Panger - AGB Lab wrote:
> Sven,

Please don't mail me in private without a good reason. At least Cc 
b.a.t.m.a.n@lists.open-mesh.org for batman-adv related things.

> This is a very important info. Gigabyte is the provider of the HW and if
> this is related to the driver I have to report them. We had some
> problems already with this driver as it doesn't set the cell number
> correctly.

It sounds more like Ralink... but that is not important right now ;)
But maybe you can provide more information about the driver (which exact 
driver did you use, ...) because some people on the mailing list may have used 
the same driver and know a workaround/fix.

> Could you give me a hint how to provide such information to them ?

The same way you contacted us... with a lot of information. But try to use a 
small tool to send unicast packets in one direction and look if you can create 
the same situation without batman-adv involved. IP is not the best solution 
because it has to send more packets and therefore create more problems when 
you just want to test a simple scenario. I usually use a small program that 
directly sends one small ethernet frame to another node over the selected 
interface while the other side only waits for this packet on a specific 
interface. So nothing really complicated.

The receiver side has to start the program like this:

$ ./rawsend ra0

and the sender has to start it with the MAC of the receiver

$ ./rawsend ra0 ca:fe:ba:de:ba:be

The receiver will exit the rawsend after it finished the receive.

So start the setup without batman-adv. Try to contact the nodes, restart the 
one node you always restarted in your tests and try to communicat with it. You 
can also use broadcast (just use the mac ff:ff:ff:ff:ff:ff as target) to test 
if unicast is the only problem.

I hope this helps to document the problem. This should allow the driver author 
to debug/reproduce the whole scenario. But please send us more information 
when this is not the problem and really batman-adv's fault.

Kind regards,
	Sven
--nextPart1733399.ln3H7qY9c7
Content-Disposition: attachment; filename="rawsend.c"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-csrc; charset="UTF-8"; name="rawsend.c"

#include <stdio.h>
#include <sys/ioctl.h>
#include <net/if.h> 
#include <sys/types.h>
#include <sys/socket.h>
#include <netpacket/packet.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <string.h>
#include <arpa/inet.h>
#include <unistd.h>

int getmac(const char *src, unsigned char *dst)
{
	unsigned int n[6];
	int i;
	if (sscanf(src, "%x:%x:%x:%x:%x:%x",
	    &n[0], &n[1], &n[2], &n[3], &n[4], &n[5]) != 6) {
		if(sscanf(src, "%2x%2x.%2x%2x.%2x%2x",
		   &n[0], &n[1], &n[2], &n[3], &n[4], &n[5]) != 6) {
			return 1;
		}
	}

	for (i = 0; i < 6; i++) {
		if (n[i] <= 255)
			dst[i] = (unsigned char)n[i];
		else
			return 1;
	}

	return 0;
}

int main(int argc, char *argv[])
{
	int rawsock;
	uint16_t type = 0x1337;
	struct ifreq req;
	struct sockaddr_ll addr;
	struct iovec vector[2];
	char buf[256];
	size_t size = 256;
	struct ether_header header;

	if (argc != 2 && argc != 3) {
		fprintf(stderr, "Usage: %s DEVICE [DST-MAC]\n", argv[0]);
		return 1;
	}

	if ((rawsock = socket(PF_PACKET, SOCK_RAW, htons(type))) < 0 ) {
			fprintf(stderr, "Could not open raw socket\n");
			return 1;
	}

	strncpy(req.ifr_name, argv[1], IFNAMSIZ);
	if (ioctl(rawsock, SIOCGIFINDEX, &req) < 0) {
		fprintf(stderr, "Could not find device %s\n", argv[1]);
		return 1;
	}

	addr.sll_family = AF_PACKET;
	addr.sll_protocol = htons(type);
	addr.sll_ifindex  = req.ifr_ifindex;

	if (bind(rawsock, (struct sockaddr *)&addr, sizeof(addr)) < 0 ) {
		fprintf(stderr, "Could not bind to device %s\n", argv[1]);
		return 1;
	}

	strncpy(req.ifr_name, argv[1], IFNAMSIZ);
	if (ioctl(rawsock, SIOCGIFHWADDR, &req) < 0) {
		fprintf(stderr, "Could not get hwaddr of device %s\n", argv[1]);
		return 1;
	}

	if (argc == 2) {
		vector[0].iov_base = &header;
		vector[0].iov_len  = sizeof(struct ether_header);
		vector[1].iov_base = buf;
		vector[1].iov_len  = size;

		if (readv(rawsock, vector, 2) < 0) {
			close(rawsock);
			fprintf(stderr, "Could not receive message\n");
			return 1;
		}
		printf("Received message\n");
	} else if (argc == 3) {
		vector[0].iov_base = &header;
		vector[0].iov_len  = sizeof(struct ether_header);
		vector[1].iov_base = buf;
		vector[1].iov_len  = size;

		header.ether_type = htons(type);

		memcpy(header.ether_shost, req.ifr_hwaddr.sa_data, ETH_ALEN);

		if (getmac(argv[2], header.ether_dhost)) {
			close(rawsock);
			fprintf(stderr, "Could not parse mac address %s\n", argv[2]);
			return 1;
		}
		if (writev(rawsock, vector, 2) < 0) {
			close(rawsock);
			fprintf(stderr, "Could not send message\n");
			return 1;
		}
	}
	close(rawsock);
	return 0;
}

--nextPart1733399.ln3H7qY9c7--

--nextPart2199464.UrB3Mcq0l2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJO3jQsAAoJEF2HCgfBJntGIK8P/R9hdyIdJIRJKEEPNkweR/XC
e4mRKMm6O53UCbjXNXkeWWzfb4Jb6fHrXJB2jQ0wXVqId6bPaX4op8EfZwvr7t4a
2KpS+QNuzx09n0jwK72G9HIEMj01un/xwf3gyY7UEShnWRaH6h582SCEo/LyoGva
NDVejhfr49Yq1ta6Qn2IAaeApRyB2vA2jgi4mh/tima46ehD0RDbrvCmDaqSeTe0
FMPJ2993PP76jVEL7jir+kFG8rY32eN3R23DL99AKcRZxcVrXgPlsbrOrHmdUAwe
qWniIv8iOHMSGh4UqJMTIy+z/zN6hPmg7Rl3rWkCfXOOJMshGdAJ8r3jEl6CSECK
k6Hl/A2J5c4MxjN18m19SDn4qtbkTpclve1rwJ5NBGTUreM83y2G/sGnBcG1OrUk
/aBi1WUGfwUQ2/q4ZWnXS+5xWHnb4Fj3Ps5Y/L5pnXgwfxx9i1tBZNm053k2kChS
K1VcT0ODXmtSHx3hlbzMU6y6NHmV7CG0vWwgDdhlh0c0CaAz3Zg0hsz28FnzbB5S
MOOZxhrMrNsR2SmrbPpnonJ3p2rjmLAYyZ8PcpSLcnRoziqFKc1f2XqQ3NiRAwk3
RavOVKnaKeGNHIEv2cL74etYQznyqYsiVvkle8m03ZULdKBb2drgZ8TqvpZfURRM
4XTQDGA91jGPxxqI+x9L
=bq2v
-----END PGP SIGNATURE-----

--nextPart2199464.UrB3Mcq0l2--

