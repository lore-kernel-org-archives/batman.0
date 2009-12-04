Return-Path: <andrew@lunn.ch>
Date: Fri, 4 Dec 2009 11:12:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20091204101245.GB32517@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [patch] batman-adv: Use printk(%pM) for MAC addresses
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

printk() since kernel version 2.6.29 has supported printing MAC
addresses directly, as an extension to the %p processing. This patch
makes use of this for printk() and bat_dbg(). This will remove the
overhead of using addr_to_string() which is normally never actually
output.

For kernels older than 2.6.29 the printk support from 2.6.31 has been
imported into batman-adv and will be used for formatting the output
before passing it onto the native printk() function.

---
Signed-off-by Andrew Lunn <andrew@lunn.ch>
Index: Makefile.kbuild
===================================================================
--- Makefile.kbuild	(revision 1490)
+++ Makefile.kbuild	(working copy)
@@ -32,4 +32,5 @@
 endif
 
 obj-m += batman-adv.o
-batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o
+batman-adv-objs := main.o proc.o send.o routing.o soft-interface.o device.o translation-table.o bitarray.o hash.o ring_buffer.o vis.o hard-interface.o aggregation.o originator.o bat_printk.o
+
Index: translation-table.c
===================================================================
--- translation-table.c	(revision 1490)
+++ translation-table.c	(working copy)
@@ -61,7 +61,6 @@
 	struct hna_local_entry *hna_local_entry;
 	struct hna_global_entry *hna_global_entry;
 	struct hashtable_t *swaphash;
-	char hna_str[ETH_STR_LEN];
 	unsigned long flags;
 
 	spin_lock_irqsave(&hna_local_hash_lock, flags);
@@ -74,19 +73,17 @@
 		return;
 	}
 
-	addr_to_string(hna_str, addr);
-
 	/* only announce as many hosts as possible in the batman-packet and
 	   space in batman_packet->num_hna That also should give a limit to
 	   MAC-flooding. */
 	if ((num_hna + 1 > (ETH_DATA_LEN - BAT_PACKET_LEN) / ETH_ALEN) ||
 	    (num_hna + 1 > 255)) {
-		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%s): number of local hna entries exceeds packet size \n", hna_str);
+		bat_dbg(DBG_ROUTES, "Can't add new local hna entry (%pM): number of local hna entries exceeds packet size \n", addr);
 		return;
 	}
 
-	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %s \n",
-		hna_str);
+	bat_dbg(DBG_ROUTES, "Creating new local hna entry: %pM \n",
+		addr);
 
 	hna_local_entry = kmalloc(sizeof(struct hna_local_entry), GFP_ATOMIC);
 	if (!hna_local_entry)
@@ -201,12 +198,9 @@
 static void hna_local_del(struct hna_local_entry *hna_local_entry,
 			  char *message)
 {
-	char hna_str[ETH_STR_LEN];
+	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%pM): %s \n",
+		hna_local_entry->addr, message);
 
-	addr_to_string(hna_str, hna_local_entry->addr);
-	bat_dbg(DBG_ROUTES, "Deleting local hna entry (%s): %s \n",
-		hna_str, message);
-
 	hash_remove(hna_local_hash, hna_local_entry->addr);
 	_hna_local_del(hna_local_entry);
 }
@@ -263,13 +257,10 @@
 	struct hna_global_entry *hna_global_entry;
 	struct hna_local_entry *hna_local_entry;
 	struct hashtable_t *swaphash;
-	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	int hna_buff_count = 0;
 	unsigned long flags;
 	unsigned char *hna_ptr;
 
-	addr_to_string(orig_str, orig_node->orig);
-
 	while ((hna_buff_count + 1) * ETH_ALEN <= hna_buff_len) {
 		spin_lock_irqsave(&hna_global_hash_lock, flags);
 
@@ -289,10 +280,9 @@
 
 			memcpy(hna_global_entry->addr, hna_ptr, ETH_ALEN);
 
-			addr_to_string(hna_str, hna_global_entry->addr);
 			bat_dbg(DBG_ROUTES,
-				"Creating new global hna entry: %s (via %s)\n",
-				hna_str, orig_str);
+				"Creating new global hna entry: %pM (via %pM)\n",
+				hna_global_entry->addr, orig_node->orig);
 
 			spin_lock_irqsave(&hna_global_hash_lock, flags);
 			hash_add(hna_global_hash, hna_global_entry);
@@ -382,14 +372,10 @@
 void _hna_global_del_orig(struct hna_global_entry *hna_global_entry,
 			  char *message)
 {
-	char hna_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
+	bat_dbg(DBG_ROUTES, "Deleting global hna entry %pM (via %pM): %s \n",
+		hna_global_entry->addr, hna_global_entry->orig_node->orig,
+		message);
 
-	addr_to_string(orig_str, hna_global_entry->orig_node->orig);
-	addr_to_string(hna_str, hna_global_entry->addr);
-
-	bat_dbg(DBG_ROUTES, "Deleting global hna entry %s (via %s): %s \n",
-		hna_str, orig_str, message);
-
 	hash_remove(hna_global_hash, hna_global_entry->addr);
 	kfree(hna_global_entry);
 }
Index: send.c
===================================================================
--- send.c	(revision 1490)
+++ send.c	(working copy)
@@ -113,7 +113,6 @@
 	uint8_t packet_num;
 	int16_t buff_pos;
 	struct batman_packet *batman_packet;
-	char orig_str[ETH_STR_LEN];
 
 	if (batman_if->if_active != IF_ACTIVE)
 		return;
@@ -135,15 +134,14 @@
 		else
 			batman_packet->flags &= ~DIRECTLINK;
 
-		addr_to_string(orig_str, batman_packet->orig);
 		fwd_str = (packet_num > 0 ? "Forwarding" : (forw_packet->own ?
 							    "Sending own" :
 							    "Forwarding"));
 		bat_dbg(DBG_BATMAN,
-			"%s %spacket (originator %s, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
+			"%s %spacket (originator %pM, seqno %d, TQ %d, TTL %d, IDF %s) on interface %s [%s]\n",
 			fwd_str,
 			(packet_num > 0 ? "aggregated " : ""),
-			orig_str, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->tq, batman_packet->ttl,
 			(batman_packet->flags & DIRECTLINK ?
 			 "on" : "off"),
@@ -167,7 +165,6 @@
 	struct batman_if *batman_if;
 	struct batman_packet *batman_packet =
 		(struct batman_packet *)(forw_packet->packet_buff);
-	char orig_str[ETH_STR_LEN];
 	unsigned char directlink = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	if (!forw_packet->if_incoming) {
@@ -178,8 +175,6 @@
 	if (forw_packet->if_incoming->if_active != IF_ACTIVE)
 		return;
 
-	addr_to_string(orig_str, batman_packet->orig);
-
 	/* multihomed peer assumed */
 	/* non-primary OGMs are only broadcasted on their interface */
 	if ((directlink && (batman_packet->ttl == 1)) ||
@@ -187,9 +182,9 @@
 
 		/* FIXME: what about aggregated packets ? */
 		bat_dbg(DBG_BATMAN,
-			"%s packet (originator %s, seqno %d, TTL %d) on interface %s [%s]\n",
+			"%s packet (originator %pM, seqno %d, TTL %d) on interface %s [%s]\n",
 			(forw_packet->own ? "Sending own" : "Forwarding"),
-			orig_str, ntohs(batman_packet->seqno),
+			batman_packet->orig, ntohs(batman_packet->seqno),
 			batman_packet->ttl, forw_packet->if_incoming->dev,
 			forw_packet->if_incoming->addr_str);
 
Index: bat_printk.c
===================================================================
--- bat_printk.c	(revision 0)
+++ bat_printk.c	(revision 0)
@@ -0,0 +1,1013 @@
+/*
+ *  linux/lib/vsprintf.c
+ *
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ */
+
+/* vsprintf.c -- Lars Wirzenius & Linus Torvalds. */
+/*
+ * Wirzenius wrote this portably, Torvalds fucked it up :-)
+ */
+
+/*
+ * Fri Jul 13 2001 Crutcher Dunnavant <crutcher+kernel@datastacks.com>
+ * - changed to provide snprintf and vsnprintf functions
+ * So Feb  1 16:51:32 CET 2004 Juergen Quade <quade@hsnr.de>
+ * - scnprintf and vscnprintf
+ */
+
+#include <stdarg.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/kernel.h>
+#include <linux/kallsyms.h>
+#include <linux/uaccess.h>
+#include <linux/ioport.h>
+#include <net/addrconf.h>
+
+#include <asm/page.h>		/* for PAGE_SIZE */
+#include <asm/div64.h>
+#include <asm/sections.h>	/* for dereference_function_descriptor() */
+
+/* Works only for digits and letters, but small and fast */
+#define TOLOWER(x) ((x) | 0x20)
+
+static int skip_atoi(const char **s)
+{
+	int i = 0;
+
+	while (isdigit(**s))
+		i = i*10 + *((*s)++) - '0';
+	return i;
+}
+
+/* Decimal conversion is by far the most typical, and is used
+ * for /proc and /sys data. This directly impacts e.g. top performance
+ * with many processes running. We optimize it for speed
+ * using code from
+ * http://www.cs.uiowa.edu/~jones/bcd/decimal.html
+ * (with permission from the author, Douglas W. Jones). */
+
+/* Formats correctly any integer in [0,99999].
+ * Outputs from one to five digits depending on input.
+ * On i386 gcc 4.1.2 -O2: ~250 bytes of code. */
+static char *put_dec_trunc(char *buf, unsigned q)
+{
+	unsigned d3, d2, d1, d0;
+	d1 = (q>>4) & 0xf;
+	d2 = (q>>8) & 0xf;
+	d3 = (q>>12);
+
+	d0 = 6*(d3 + d2 + d1) + (q & 0xf);
+	q = (d0 * 0xcd) >> 11;
+	d0 = d0 - 10*q;
+	*buf++ = d0 + '0'; /* least significant digit */
+	d1 = q + 9*d3 + 5*d2 + d1;
+	if (d1 != 0) {
+		q = (d1 * 0xcd) >> 11;
+		d1 = d1 - 10*q;
+		*buf++ = d1 + '0'; /* next digit */
+
+		d2 = q + 2*d2;
+		if ((d2 != 0) || (d3 != 0)) {
+			q = (d2 * 0xd) >> 7;
+			d2 = d2 - 10*q;
+			*buf++ = d2 + '0'; /* next digit */
+
+			d3 = q + 4*d3;
+			if (d3 != 0) {
+				q = (d3 * 0xcd) >> 11;
+				d3 = d3 - 10*q;
+				*buf++ = d3 + '0';  /* next digit */
+				if (q != 0)
+					/* most sign. digit */
+					*buf++ = q + '0';
+			}
+		}
+	}
+	return buf;
+}
+/* Same with if's removed. Always emits five digits */
+static char *put_dec_full(char *buf, unsigned q)
+{
+	/* BTW, if q is in [0,9999], 8-bit ints will be enough, */
+	/* but anyway, gcc produces better code with full-sized ints */
+	unsigned d3, d2, d1, d0;
+	d1 = (q>>4) & 0xf;
+	d2 = (q>>8) & 0xf;
+	d3 = (q>>12);
+
+	/* Possible ways to approx. divide by 10 */
+	/* gcc -O2 replaces multiply with shifts and adds */
+	/* (x * 0xcd) >> 11: 11001101 - shorter code than * 0x67 (on i386) */
+	/* (x * 0x67) >> 10:  1100111					   */
+	/* (x * 0x34) >> 9:    110100 - same				   */
+	/* (x * 0x1a) >> 8:	11010 - same				   */
+	/* (x * 0x0d) >> 7:	 1101 - same, shortest code (on i386)	   */
+
+	d0 = 6*(d3 + d2 + d1) + (q & 0xf);
+	q = (d0 * 0xcd) >> 11;
+	d0 = d0 - 10*q;
+	*buf++ = d0 + '0';
+	d1 = q + 9*d3 + 5*d2 + d1;
+		q = (d1 * 0xcd) >> 11;
+		d1 = d1 - 10*q;
+		*buf++ = d1 + '0';
+
+		d2 = q + 2*d2;
+			q = (d2 * 0xd) >> 7;
+			d2 = d2 - 10*q;
+			*buf++ = d2 + '0';
+
+			d3 = q + 4*d3;
+				q = (d3 * 0xcd) >> 11; /* - shorter code */
+				/* q = (d3 * 0x67) >> 10; - would also work */
+				d3 = d3 - 10*q;
+				*buf++ = d3 + '0';
+					*buf++ = q + '0';
+	return buf;
+}
+/* No inlining helps gcc to use registers better */
+static noinline char *put_dec(char *buf, unsigned long long num)
+{
+	while (1) {
+		unsigned rem;
+		if (num < 100000)
+			return put_dec_trunc(buf, num);
+		rem = do_div(num, 100000);
+		buf = put_dec_full(buf, rem);
+	}
+}
+
+#define ZEROPAD	1		/* pad with zero */
+#define SIGN	2		/* unsigned/signed long */
+#define PLUS	4		/* show plus */
+#define SPACE	8		/* space if plus */
+#define LEFT	16		/* left justified */
+#define SMALL	32		/* Must be 32 == 0x20 */
+#define SPECIAL	64		/* 0x */
+
+enum format_type {
+	FORMAT_TYPE_NONE, /* Just a string part */
+	FORMAT_TYPE_WIDTH,
+	FORMAT_TYPE_PRECISION,
+	FORMAT_TYPE_CHAR,
+	FORMAT_TYPE_STR,
+	FORMAT_TYPE_PTR,
+	FORMAT_TYPE_PERCENT_CHAR,
+	FORMAT_TYPE_INVALID,
+	FORMAT_TYPE_LONG_LONG,
+	FORMAT_TYPE_ULONG,
+	FORMAT_TYPE_LONG,
+	FORMAT_TYPE_UBYTE,
+	FORMAT_TYPE_BYTE,
+	FORMAT_TYPE_USHORT,
+	FORMAT_TYPE_SHORT,
+	FORMAT_TYPE_UINT,
+	FORMAT_TYPE_INT,
+	FORMAT_TYPE_NRCHARS,
+	FORMAT_TYPE_SIZE_T,
+	FORMAT_TYPE_PTRDIFF
+};
+
+struct printf_spec {
+	enum format_type	type;
+	int			flags;		/* flags to number() */
+	int			field_width;	/* width of output field */
+	int			base;
+	int			precision;	/* # of digits/chars */
+	int			qualifier;
+};
+
+static char *number(char *buf, char *end, unsigned long long num,
+			struct printf_spec spec)
+{
+	/* we are called with base 8, 10 or 16, only, thus don't need "G..."  */
+	static const char digits[16] = "0123456789ABCDEF";
+
+	char tmp[66];
+	char sign;
+	char locase;
+	int need_pfx = ((spec.flags & SPECIAL) && spec.base != 10);
+	int i;
+
+	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
+	 * produces same digits or (maybe lowercased) letters */
+	locase = (spec.flags & SMALL);
+	if (spec.flags & LEFT)
+		spec.flags &= ~ZEROPAD;
+	sign = 0;
+	if (spec.flags & SIGN) {
+		if ((signed long long) num < 0) {
+			sign = '-';
+			num = -(signed long long) num;
+			spec.field_width--;
+		} else if (spec.flags & PLUS) {
+			sign = '+';
+			spec.field_width--;
+		} else if (spec.flags & SPACE) {
+			sign = ' ';
+			spec.field_width--;
+		}
+	}
+	if (need_pfx) {
+		spec.field_width--;
+		if (spec.base == 16)
+			spec.field_width--;
+	}
+
+	/* generate full string in tmp[], in reverse order */
+	i = 0;
+	if (num == 0)
+		tmp[i++] = '0';
+	/* Generic code, for any base:
+	else do {
+		tmp[i++] = (digits[do_div(num,base)] | locase);
+	} while (num != 0);
+	*/
+	else if (spec.base != 10) { /* 8 or 16 */
+		int mask = spec.base - 1;
+		int shift = 3;
+		if (spec.base == 16)
+			shift = 4;
+		do {
+			tmp[i++] = (digits[((unsigned char)num) & mask]
+				    | locase);
+			num >>= shift;
+		} while (num);
+	} else { /* base 10 */
+		i = put_dec(tmp, num) - tmp;
+	}
+
+	/* printing 100 using %2d gives "100", not "00" */
+	if (i > spec.precision)
+		spec.precision = i;
+	/* leading space padding */
+	spec.field_width -= spec.precision;
+	if (!(spec.flags & (ZEROPAD+LEFT))) {
+		while (--spec.field_width >= 0) {
+			if (buf < end)
+				*buf = ' ';
+			++buf;
+		}
+	}
+	/* sign */
+	if (sign) {
+		if (buf < end)
+			*buf = sign;
+		++buf;
+	}
+	/* "0x" / "0" prefix */
+	if (need_pfx) {
+		if (buf < end)
+			*buf = '0';
+		++buf;
+		if (spec.base == 16) {
+			if (buf < end)
+				*buf = ('X' | locase);
+			++buf;
+		}
+	}
+	/* zero or space padding */
+	if (!(spec.flags & LEFT)) {
+		char c = (spec.flags & ZEROPAD) ? '0' : ' ';
+		while (--spec.field_width >= 0) {
+			if (buf < end)
+				*buf = c;
+			++buf;
+		}
+	}
+	/* hmm even more zero padding? */
+	while (i <= --spec.precision) {
+		if (buf < end)
+			*buf = '0';
+		++buf;
+	}
+	/* actual digits of result */
+	while (--i >= 0) {
+		if (buf < end)
+			*buf = tmp[i];
+		++buf;
+	}
+	/* trailing space padding */
+	while (--spec.field_width >= 0) {
+		if (buf < end)
+			*buf = ' ';
+		++buf;
+	}
+	return buf;
+}
+
+static char *string(char *buf, char *end, char *s, struct printf_spec spec)
+{
+	int len, i;
+
+	if ((unsigned long)s < PAGE_SIZE)
+		s = "<NULL>";
+
+	len = strnlen(s, spec.precision);
+
+	if (!(spec.flags & LEFT)) {
+		while (len < spec.field_width--) {
+			if (buf < end)
+				*buf = ' ';
+			++buf;
+		}
+	}
+	for (i = 0; i < len; ++i) {
+		if (buf < end)
+			*buf = *s;
+		++buf; ++s;
+	}
+	while (len < spec.field_width--) {
+		if (buf < end)
+			*buf = ' ';
+		++buf;
+	}
+	return buf;
+}
+
+static char *resource_string(char *buf, char *end, struct resource *res,
+				struct printf_spec spec)
+{
+#ifndef IO_RSRC_PRINTK_SIZE
+#define IO_RSRC_PRINTK_SIZE	4
+#endif
+
+#ifndef MEM_RSRC_PRINTK_SIZE
+#define MEM_RSRC_PRINTK_SIZE	8
+#endif
+	struct printf_spec num_spec = {
+		.base = 16,
+		.precision = -1,
+		.flags = SPECIAL | SMALL | ZEROPAD,
+	};
+	/* room for the actual numbers, the two "0x", -, [, ] and the final
+	   zero */
+	char sym[4*sizeof(resource_size_t) + 8];
+	char *p = sym, *pend = sym + sizeof(sym);
+	int size = -1;
+
+	if (res->flags & IORESOURCE_IO)
+		size = IO_RSRC_PRINTK_SIZE;
+	else if (res->flags & IORESOURCE_MEM)
+		size = MEM_RSRC_PRINTK_SIZE;
+
+	*p++ = '[';
+	num_spec.field_width = size;
+	p = number(p, pend, res->start, num_spec);
+	*p++ = '-';
+	p = number(p, pend, res->end, num_spec);
+	*p++ = ']';
+	*p = 0;
+
+	return string(buf, end, sym, spec);
+}
+
+static char *mac_address_string(char *buf, char *end, u8 *addr,
+				struct printf_spec spec, const char *fmt)
+{
+	char mac_addr[sizeof("xx:xx:xx:xx:xx:xx")];
+	char *p = mac_addr;
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		p = pack_hex_byte(p, addr[i]);
+		if (fmt[0] == 'M' && i != 5)
+			*p++ = ':';
+	}
+	*p = '\0';
+
+	return string(buf, end, mac_addr, spec);
+}
+
+static char *ip4_string(char *p, const u8 *addr, bool leading_zeros)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		char temp[3];	/* hold each IP quad in reverse order */
+		int digits = put_dec_trunc(temp, addr[i]) - temp;
+		if (leading_zeros) {
+			if (digits < 3)
+				*p++ = '0';
+			if (digits < 2)
+				*p++ = '0';
+		}
+		/* reverse the digits in the quad */
+		while (digits--)
+			*p++ = temp[digits];
+		if (i < 3)
+			*p++ = '.';
+	}
+
+	*p = '\0';
+	return p;
+}
+
+static char *ip6_compressed_string(char *p, const char *addr)
+{
+	int i;
+	int j;
+	int range;
+	unsigned char zerolength[8];
+	int longest = 1;
+	int colonpos = -1;
+	u16 word;
+	u8 hi;
+	u8 lo;
+	bool needcolon = false;
+	bool useIPv4;
+	struct in6_addr in6;
+
+	memcpy(&in6, addr, sizeof(struct in6_addr));
+
+	useIPv4 = ipv6_addr_v4mapped(&in6) || ipv6_addr_is_isatap(&in6);
+
+	memset(zerolength, 0, sizeof(zerolength));
+
+	if (useIPv4)
+		range = 6;
+	else
+		range = 8;
+
+	/* find position of longest 0 run */
+	for (i = 0; i < range; i++) {
+		for (j = i; j < range; j++) {
+			if (in6.s6_addr16[j] != 0)
+				break;
+			zerolength[i]++;
+		}
+	}
+	for (i = 0; i < range; i++) {
+		if (zerolength[i] > longest) {
+			longest = zerolength[i];
+			colonpos = i;
+		}
+	}
+
+	/* emit address */
+	for (i = 0; i < range; i++) {
+		if (i == colonpos) {
+			if (needcolon || i == 0)
+				*p++ = ':';
+			*p++ = ':';
+			needcolon = false;
+			i += longest - 1;
+			continue;
+		}
+		if (needcolon) {
+			*p++ = ':';
+			needcolon = false;
+		}
+		/* hex u16 without leading 0s */
+		word = ntohs(in6.s6_addr16[i]);
+		hi = word >> 8;
+		lo = word & 0xff;
+		if (hi) {
+			if (hi > 0x0f)
+				p = pack_hex_byte(p, hi);
+			else
+				*p++ = hex_asc_lo(hi);
+		}
+		if (hi || lo > 0x0f)
+			p = pack_hex_byte(p, lo);
+		else
+			*p++ = hex_asc_lo(lo);
+		needcolon = true;
+	}
+
+	if (useIPv4) {
+		if (needcolon)
+			*p++ = ':';
+		p = ip4_string(p, &in6.s6_addr[12], false);
+	}
+
+	*p = '\0';
+	return p;
+}
+
+static char *ip6_string(char *p, const char *addr, const char *fmt)
+{
+	int i;
+	for (i = 0; i < 8; i++) {
+		p = pack_hex_byte(p, *addr++);
+		p = pack_hex_byte(p, *addr++);
+		if (fmt[0] == 'I' && i != 7)
+			*p++ = ':';
+	}
+
+	*p = '\0';
+	return p;
+}
+
+static char *ip6_addr_string(char *buf, char *end, const u8 *addr,
+			     struct printf_spec spec, const char *fmt)
+{
+	char ip6_addr[sizeof("xxxx:xxxx:xxxx:xxxx:xxxx:xxxx:255.255.255.255")];
+
+	if (fmt[0] == 'I' && fmt[2] == 'c')
+		ip6_compressed_string(ip6_addr, addr);
+	else
+		ip6_string(ip6_addr, addr, fmt);
+
+	return string(buf, end, ip6_addr, spec);
+}
+
+static char *ip4_addr_string(char *buf, char *end, const u8 *addr,
+			     struct printf_spec spec, const char *fmt)
+{
+	char ip4_addr[sizeof("255.255.255.255")];
+
+	ip4_string(ip4_addr, addr, fmt[0] == 'i');
+
+	return string(buf, end, ip4_addr, spec);
+}
+
+/*
+ * Show a '%p' thing.  A kernel extension is that the '%p' is followed
+ * by an extra set of alphanumeric characters that are extended format
+ * specifiers.
+ *
+ * Right now we handle:
+ *
+ * - 'F' For symbolic function descriptor pointers with offset
+ * - 'f' For simple symbolic function names without offset
+ * - 'R' For a struct resource pointer, it prints the range of
+ *	 addresses (not the name nor the flags)
+ * - 'M' For a 6-byte MAC address, it prints the address in the
+ *	 usual colon-separated hex notation
+ * - 'm' For a 6-byte MAC address, it prints the hex address without colons
+ * - 'I' [46] for IPv4/IPv6 addresses printed in the usual way
+ *	 IPv4 uses dot-separated decimal without leading 0's (1.2.3.4)
+ *	 IPv6 uses colon separated network-order 16 bit hex with leading 0's
+ * - 'i' [46] for 'raw' IPv4/IPv6 addresses
+ *	 IPv6 omits the colons (01020304...0f)
+ *	 IPv4 uses dot-separated decimal with leading 0's (010.123.045.006)
+ * - 'I6c' for IPv6 addresses printed as specified by
+ *	 http://www.ietf.org/id/draft-kawamura-ipv6-text-representation-03.txt
+ * Note: The difference between 'S' and 'F' is that on ia64 and ppc64
+ * function pointers are really function descriptors, which contain a
+ * pointer to the real address.
+ */
+static char *pointer(const char *fmt, char *buf, char *end, void *ptr,
+			struct printf_spec spec)
+{
+	if (!ptr)
+		return string(buf, end, "(null)", spec);
+
+	switch (*fmt) {
+	case 'F':
+	case 'f':
+		ptr = dereference_function_descriptor(ptr);
+	case 'R':
+		return resource_string(buf, end, ptr, spec);
+	case 'M':			/* Colon separated: 00:01:02:03:04:05 */
+	case 'm':			/* Contiguous: 000102030405 */
+		return mac_address_string(buf, end, ptr, spec, fmt);
+	case 'I':			/* Formatted IP supported
+					 * 4:	1.2.3.4
+					 * 6:	0001:0203:...:0708
+					 * 6c:	1::708 or 1::1.2.3.4
+					 */
+	case 'i':			/* Contiguous:
+					 * 4:	001.002.003.004
+					 * 6:	000102...0f
+					 */
+		switch (fmt[1]) {
+		case '6':
+			return ip6_addr_string(buf, end, ptr, spec, fmt);
+		case '4':
+			return ip4_addr_string(buf, end, ptr, spec, fmt);
+		}
+		break;
+	}
+	spec.flags |= SMALL;
+	if (spec.field_width == -1) {
+		spec.field_width = 2*sizeof(void *);
+		spec.flags |= ZEROPAD;
+	}
+	spec.base = 16;
+
+	return number(buf, end, (unsigned long) ptr, spec);
+}
+
+/*
+ * Helper function to decode printf style format.
+ * Each call decode a token from the format and return the
+ * number of characters read (or likely the delta where it wants
+ * to go on the next call).
+ * The decoded token is returned through the parameters
+ *
+ * 'h', 'l', or 'L' for integer fields
+ * 'z' support added 23/7/1999 S.H.
+ * 'z' changed to 'Z' --davidm 1/25/99
+ * 't' added for ptrdiff_t
+ *
+ * @fmt: the format string
+ * @type of the token returned
+ * @flags: various flags such as +, -, # tokens..
+ * @field_width: overwritten width
+ * @base: base of the number (octal, hex, ...)
+ * @precision: precision of a number
+ * @qualifier: qualifier of a number (long, size_t, ...)
+ */
+static int format_decode(const char *fmt, struct printf_spec *spec)
+{
+	const char *start = fmt;
+
+	/* we finished early by reading the field width */
+	if (spec->type == FORMAT_TYPE_WIDTH) {
+		if (spec->field_width < 0) {
+			spec->field_width = -spec->field_width;
+			spec->flags |= LEFT;
+		}
+		spec->type = FORMAT_TYPE_NONE;
+		goto precision;
+	}
+
+	/* we finished early by reading the precision */
+	if (spec->type == FORMAT_TYPE_PRECISION) {
+		if (spec->precision < 0)
+			spec->precision = 0;
+
+		spec->type = FORMAT_TYPE_NONE;
+		goto qualifier;
+	}
+
+	/* By default */
+	spec->type = FORMAT_TYPE_NONE;
+
+	for (; *fmt ; ++fmt) {
+		if (*fmt == '%')
+			break;
+	}
+
+	/* Return the current non-format string */
+	if (fmt != start || !*fmt)
+		return fmt - start;
+
+	/* Process flags */
+	spec->flags = 0;
+
+	while (1) { /* this also skips first '%' */
+		bool found = true;
+
+		++fmt;
+
+		switch (*fmt) {
+		case '-':
+			spec->flags |= LEFT;
+			break;
+		case '+':
+			spec->flags |= PLUS;
+			break;
+		case ' ':
+			spec->flags |= SPACE;
+			break;
+		case '#':
+			spec->flags |= SPECIAL;
+			break;
+		case '0':
+			spec->flags |= ZEROPAD;
+			break;
+		default:
+			found = false;
+		}
+
+		if (!found)
+			break;
+	}
+
+	/* get field width */
+	spec->field_width = -1;
+
+	if (isdigit(*fmt))
+		spec->field_width = skip_atoi(&fmt);
+	else if (*fmt == '*') {
+		/* it's the next argument */
+		spec->type = FORMAT_TYPE_WIDTH;
+		return ++fmt - start;
+	}
+
+precision:
+	/* get the precision */
+	spec->precision = -1;
+	if (*fmt == '.') {
+		++fmt;
+		if (isdigit(*fmt)) {
+			spec->precision = skip_atoi(&fmt);
+			if (spec->precision < 0)
+				spec->precision = 0;
+		} else if (*fmt == '*') {
+			/* it's the next argument */
+			spec->type = FORMAT_TYPE_PRECISION;
+			return ++fmt - start;
+		}
+	}
+
+qualifier:
+	/* get the conversion qualifier */
+	spec->qualifier = -1;
+	if (*fmt == 'h' || *fmt == 'l' || *fmt == 'L' ||
+	    *fmt == 'Z' || *fmt == 'z' || *fmt == 't') {
+		spec->qualifier = *fmt++;
+		if (unlikely(spec->qualifier == *fmt)) {
+			if (spec->qualifier == 'l') {
+				spec->qualifier = 'L';
+				++fmt;
+			} else if (spec->qualifier == 'h') {
+				spec->qualifier = 'H';
+				++fmt;
+			}
+		}
+	}
+
+	/* default base */
+	spec->base = 10;
+	switch (*fmt) {
+	case 'c':
+		spec->type = FORMAT_TYPE_CHAR;
+		return ++fmt - start;
+
+	case 's':
+		spec->type = FORMAT_TYPE_STR;
+		return ++fmt - start;
+
+	case 'p':
+		spec->type = FORMAT_TYPE_PTR;
+		return fmt - start;
+		/* skip alnum */
+
+	case 'n':
+		spec->type = FORMAT_TYPE_NRCHARS;
+		return ++fmt - start;
+
+	case '%':
+		spec->type = FORMAT_TYPE_PERCENT_CHAR;
+		return ++fmt - start;
+
+	/* integer number formats - set up the flags and "break" */
+	case 'o':
+		spec->base = 8;
+		break;
+
+	case 'x':
+		spec->flags |= SMALL;
+
+	case 'X':
+		spec->base = 16;
+		break;
+
+	case 'd':
+	case 'i':
+		spec->flags |= SIGN;
+	case 'u':
+		break;
+
+	default:
+		spec->type = FORMAT_TYPE_INVALID;
+		return fmt - start;
+	}
+
+	if (spec->qualifier == 'L')
+		spec->type = FORMAT_TYPE_LONG_LONG;
+	else if (spec->qualifier == 'l') {
+		if (spec->flags & SIGN)
+			spec->type = FORMAT_TYPE_LONG;
+		else
+			spec->type = FORMAT_TYPE_ULONG;
+	} else if (spec->qualifier == 'Z' || spec->qualifier == 'z') {
+		spec->type = FORMAT_TYPE_SIZE_T;
+	} else if (spec->qualifier == 't') {
+		spec->type = FORMAT_TYPE_PTRDIFF;
+	} else if (spec->qualifier == 'H') {
+		if (spec->flags & SIGN)
+			spec->type = FORMAT_TYPE_BYTE;
+		else
+			spec->type = FORMAT_TYPE_UBYTE;
+	} else if (spec->qualifier == 'h') {
+		if (spec->flags & SIGN)
+			spec->type = FORMAT_TYPE_SHORT;
+		else
+			spec->type = FORMAT_TYPE_USHORT;
+	} else {
+		if (spec->flags & SIGN)
+			spec->type = FORMAT_TYPE_INT;
+		else
+			spec->type = FORMAT_TYPE_UINT;
+	}
+
+	return ++fmt - start;
+}
+
+/**
+ * bat_vsnprintf - Format a string and place it in a buffer
+ * @buf: The buffer to place the result into
+ * @size: The size of the buffer, including the trailing null space
+ * @fmt: The format string to use
+ * @args: Arguments for the format string
+ *
+ * This function follows C99 bat_vsnprintf, but has some extensions:
+ * %pS output the name of a text symbol with offset
+ * %ps output the name of a text symbol without offset
+ * %pF output the name of a function pointer with its offset
+ * %pf output the name of a function pointer without its offset
+ * %pR output the address range in a struct resource
+ * %n is ignored
+ *
+ * The return value is the number of characters which would
+ * be generated for the given input, excluding the trailing
+ * '\0', as per ISO C99. If you want to have the exact
+ * number of characters written into @buf as return value
+ * (not including the trailing '\0'), use vscnprintf(). If the
+ * return is greater than or equal to @size, the resulting
+ * string is truncated.
+ *
+ * Call this function if you are already dealing with a va_list.
+ * You probably want snprintf() instead.
+ */
+static int bat_vsnprintf(char *buf, size_t size, const char *fmt, va_list args)
+{
+	unsigned long long num;
+	char *str, *end, c;
+	int read;
+	struct printf_spec spec = {0};
+
+	/* Reject out-of-range values early.  Large positive sizes are
+	   used for unknown buffer sizes. */
+	if (WARN_ON_ONCE((int) size < 0))
+		return 0;
+
+	str = buf;
+	end = buf + size;
+
+	/* Make sure end is always >= buf */
+	if (end < buf) {
+		end = ((void *)-1);
+		size = end - buf;
+	}
+
+	while (*fmt) {
+		const char *old_fmt = fmt;
+
+		read = format_decode(fmt, &spec);
+
+		fmt += read;
+
+		switch (spec.type) {
+		case FORMAT_TYPE_NONE: {
+			int copy = read;
+			if (str < end) {
+				if (copy > end - str)
+					copy = end - str;
+				memcpy(str, old_fmt, copy);
+			}
+			str += read;
+			break;
+		}
+
+		case FORMAT_TYPE_WIDTH:
+			spec.field_width = va_arg(args, int);
+			break;
+
+		case FORMAT_TYPE_PRECISION:
+			spec.precision = va_arg(args, int);
+			break;
+
+		case FORMAT_TYPE_CHAR:
+			if (!(spec.flags & LEFT)) {
+				while (--spec.field_width > 0) {
+					if (str < end)
+						*str = ' ';
+					++str;
+
+				}
+			}
+			c = (unsigned char) va_arg(args, int);
+			if (str < end)
+				*str = c;
+			++str;
+			while (--spec.field_width > 0) {
+				if (str < end)
+					*str = ' ';
+				++str;
+			}
+			break;
+
+		case FORMAT_TYPE_STR:
+			str = string(str, end, va_arg(args, char *), spec);
+			break;
+
+		case FORMAT_TYPE_PTR:
+			str = pointer(fmt+1, str, end, va_arg(args, void *),
+				      spec);
+			while (isalnum(*fmt))
+				fmt++;
+			break;
+
+		case FORMAT_TYPE_PERCENT_CHAR:
+			if (str < end)
+				*str = '%';
+			++str;
+			break;
+
+		case FORMAT_TYPE_INVALID:
+			if (str < end)
+				*str = '%';
+			++str;
+			break;
+
+		case FORMAT_TYPE_NRCHARS: {
+			int qualifier = spec.qualifier;
+
+			if (qualifier == 'l') {
+				long *ip = va_arg(args, long *);
+				*ip = (str - buf);
+			} else if (qualifier == 'Z' ||
+					qualifier == 'z') {
+				size_t *ip = va_arg(args, size_t *);
+				*ip = (str - buf);
+			} else {
+				int *ip = va_arg(args, int *);
+				*ip = (str - buf);
+			}
+			break;
+		}
+
+		default:
+			switch (spec.type) {
+			case FORMAT_TYPE_LONG_LONG:
+				num = va_arg(args, long long);
+				break;
+			case FORMAT_TYPE_ULONG:
+				num = va_arg(args, unsigned long);
+				break;
+			case FORMAT_TYPE_LONG:
+				num = va_arg(args, long);
+				break;
+			case FORMAT_TYPE_SIZE_T:
+				num = va_arg(args, size_t);
+				break;
+			case FORMAT_TYPE_PTRDIFF:
+				num = va_arg(args, ptrdiff_t);
+				break;
+			case FORMAT_TYPE_UBYTE:
+				num = (unsigned char) va_arg(args, int);
+				break;
+			case FORMAT_TYPE_BYTE:
+				num = (signed char) va_arg(args, int);
+				break;
+			case FORMAT_TYPE_USHORT:
+				num = (unsigned short) va_arg(args, int);
+				break;
+			case FORMAT_TYPE_SHORT:
+				num = (short) va_arg(args, int);
+				break;
+			case FORMAT_TYPE_INT:
+				num = (int) va_arg(args, int);
+				break;
+			default:
+				num = va_arg(args, unsigned int);
+			}
+
+			str = number(str, end, num, spec);
+		}
+	}
+
+	if (size > 0) {
+		if (str < end)
+			*str = '\0';
+		else
+			end[-1] = '\0';
+	}
+
+	/* the trailing null byte doesn't count towards the total */
+	return str-buf;
+
+}
+
+/**
+ * bat_printk - print a kernel message using extra %p formatting
+ * strings, forward compatible with kernel version 2.6.31 printk, minus
+ * *p[sS].
+ *
+ * @fmt: format string
+ *
+ * This is printk().  It can be called from any context.  We want it to work.
+ *
+ */
+asmlinkage int bat_printk(const char *fmt, ...)
+{
+	va_list args;
+	int r;
+	char buf[256];
+
+	va_start(args, fmt);
+	r = bat_vsnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+
+	return printk("foo:%s", buf);
+}
Index: hard-interface.c
===================================================================
--- hard-interface.c	(revision 1490)
+++ hard-interface.c	(working copy)
@@ -74,7 +74,6 @@
 static void check_known_mac_addr(uint8_t *addr)
 {
 	struct batman_if *batman_if;
-	char mac_string[ETH_STR_LEN];
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
@@ -85,9 +84,8 @@
 		if (!compare_orig(batman_if->net_dev->dev_addr, addr))
 			continue;
 
-		addr_to_string(mac_string, addr);
-		printk(KERN_WARNING "batman-adv:The newly added mac address (%s) already exists on: %s\n",
-		       mac_string, batman_if->dev);
+		printk(KERN_WARNING "batman-adv:The newly added mac address (%pM) already exists on: %s\n",
+		       addr, batman_if->dev);
 		printk(KERN_WARNING "batman-adv:It is strongly recommended to keep mac addresses unique to avoid problems!\n");
 	}
 	rcu_read_unlock();
@@ -399,8 +397,7 @@
 	return 1;
 
 out:
-	if (batman_if->packet_buff)
-		kfree(batman_if->packet_buff);
+	kfree(batman_if->packet_buff);
 	kfree(batman_if);
 	kfree(dev);
 	return -1;
Index: originator.c
===================================================================
--- originator.c	(revision 1490)
+++ originator.c	(working copy)
@@ -115,7 +115,6 @@
 {
 	struct orig_node *orig_node;
 	struct hashtable_t *swaphash;
-	char orig_str[ETH_STR_LEN];
 	int size;
 
 	orig_node = ((struct orig_node *)hash_find(orig_hash, addr));
@@ -123,8 +122,7 @@
 	if (orig_node != NULL)
 		return orig_node;
 
-	addr_to_string(orig_str, addr);
-	bat_dbg(DBG_BATMAN, "Creating new originator: %s \n", orig_str);
+	bat_dbg(DBG_BATMAN, "Creating new originator: %pM \n", addr);
 
 	orig_node = kmalloc(sizeof(struct orig_node), GFP_ATOMIC);
 	memset(orig_node, 0, sizeof(struct orig_node));
@@ -163,13 +161,11 @@
 				 struct neigh_node **best_neigh_node)
 {
 	struct list_head *list_pos, *list_pos_tmp;
-	char neigh_str[ETH_STR_LEN], orig_str[ETH_STR_LEN];
 	struct neigh_node *neigh_node;
 	bool neigh_purged = false;
 
 	*best_neigh_node = NULL;
 
-
 	/* for all neighbours towards this originator ... */
 	list_for_each_safe(list_pos, list_pos_tmp, &orig_node->neigh_list) {
 		neigh_node = list_entry(list_pos, struct neigh_node, list);
@@ -178,9 +174,7 @@
 			       (neigh_node->last_valid +
 				((PURGE_TIMEOUT * HZ) / 1000)))) {
 
-			addr_to_string(neigh_str, neigh_node->addr);
-			addr_to_string(orig_str, orig_node->orig);
-			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %s, neighbour: %s, last_valid %lu\n", orig_str, neigh_str, (neigh_node->last_valid / HZ));
+			bat_dbg(DBG_BATMAN, "Neighbour timeout: originator %pM, neighbour: %pM, last_valid %lu\n", orig_node->orig, neigh_node->addr, (neigh_node->last_valid / HZ));
 
 			neigh_purged = true;
 			list_del(list_pos);
@@ -198,17 +192,14 @@
 static bool purge_orig_node(struct orig_node *orig_node)
 {
 	struct neigh_node *best_neigh_node;
-	char orig_str[ETH_STR_LEN];
 
-	addr_to_string(orig_str, orig_node->orig);
-
 	if (time_after(jiffies,
 		       (orig_node->last_valid +
 			((2 * PURGE_TIMEOUT * HZ) / 1000)))) {
 
 		bat_dbg(DBG_BATMAN,
-			"Originator timeout: originator %s, last_valid %lu\n",
-			orig_str, (orig_node->last_valid / HZ));
+			"Originator timeout: originator %pM, last_valid %lu\n",
+			orig_node->orig, (orig_node->last_valid / HZ));
 		return true;
 	} else {
 		if (purge_orig_neigbours(orig_node, &best_neigh_node))
@@ -239,5 +230,3 @@
 
 	start_purge_timer();
 }
-
-
Index: routing.c
===================================================================
--- routing.c	(revision 1490)
+++ routing.c	(working copy)
@@ -79,32 +79,24 @@
 			 struct neigh_node *neigh_node,
 			 unsigned char *hna_buff, int hna_buff_len)
 {
-	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
-	char router_str[ETH_STR_LEN];
-
-	addr_to_string(orig_str, orig_node->orig);
-
 	/* route deleted */
 	if ((orig_node->router != NULL) && (neigh_node == NULL)) {
 
-		bat_dbg(DBG_ROUTES, "Deleting route towards: %s\n",
-			orig_str);
+		bat_dbg(DBG_ROUTES, "Deleting route towards: %pMs\n",
+			orig_node->orig);
 		hna_global_del_orig(orig_node, "originator timed out");
 
 		/* route added */
 	} else if ((orig_node->router == NULL) && (neigh_node != NULL)) {
 
-		addr_to_string(neigh_str, neigh_node->addr);
 		bat_dbg(DBG_ROUTES,
-			"Adding route towards: %s (via %s)\n",
-			orig_str, neigh_str);
+			"Adding route towards: %pM (via %pM)\n",
+			orig_node->orig, neigh_node->addr);
 		hna_global_add_orig(orig_node, hna_buff, hna_buff_len);
 
 		/* route changed */
 	} else {
-		addr_to_string(neigh_str, neigh_node->addr);
-		addr_to_string(router_str, orig_node->router->addr);
-		bat_dbg(DBG_ROUTES, "Changing route towards: %s (now via %s - was via %s)\n", orig_str, neigh_str, router_str);
+		bat_dbg(DBG_ROUTES, "Changing route towards: %pM (now via %pM - was via %pM)\n", orig_node->orig, neigh_node->addr, orig_node->router->addr);
 	}
 
 	if (neigh_node != NULL)
@@ -137,12 +129,8 @@
 				struct batman_if *if_incoming)
 {
 	struct neigh_node *neigh_node = NULL, *tmp_neigh_node = NULL;
-	char orig_str[ETH_STR_LEN], neigh_str[ETH_STR_LEN];
 	unsigned char total_count;
 
-	addr_to_string(orig_str, orig_node->orig);
-	addr_to_string(neigh_str, orig_neigh_node->orig);
-
 	if (orig_node == orig_neigh_node) {
 		list_for_each_entry(tmp_neigh_node,
 				    &orig_node->neigh_list,
@@ -220,8 +208,8 @@
 			      orig_neigh_node->tq_asym_penalty) /
 			     (TQ_MAX_VALUE *	 TQ_MAX_VALUE));
 
-	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15s neigh = %-15s => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
-		orig_str, neigh_str, total_count,
+	bat_dbg(DBG_BATMAN, "bidirectional: orig = %-15pM neigh = %-15pM => own_bcast = %2i, real recv = %2i, local tq: %3i, asym_penalty: %3i, total tq: %3i \n",
+		orig_node->orig, orig_neigh_node->orig, total_count,
 		neigh_node->real_packet_count, orig_neigh_node->tq_own,
 		orig_neigh_node->tq_asym_penalty, batman_packet->tq);
 
@@ -358,8 +346,6 @@
 {
 	struct batman_if *batman_if;
 	struct orig_node *orig_neigh_node, *orig_node;
-	char orig_str[ETH_STR_LEN], prev_sender_str[ETH_STR_LEN];
-	char neigh_str[ETH_STR_LEN];
 	char has_directlink_flag;
 	char is_my_addr = 0, is_my_orig = 0, is_my_oldorig = 0;
 	char is_broadcast = 0, is_bidirectional, is_single_hop_neigh;
@@ -384,20 +370,16 @@
 	/* could be changed by schedule_own_packet() */
 	if_incoming_seqno = atomic_read(&if_incoming->seqno);
 
-	addr_to_string(orig_str, batman_packet->orig);
-	addr_to_string(prev_sender_str, batman_packet->prev_sender);
-	addr_to_string(neigh_str, ethhdr->h_source);
-
 	has_directlink_flag = (batman_packet->flags & DIRECTLINK ? 1 : 0);
 
 	is_single_hop_neigh = (compare_orig(ethhdr->h_source,
 					    batman_packet->orig) ? 1 : 0);
 
-	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %s, IF: %s [%s] (from OG: %s, via prev OG: %s, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
-		neigh_str, if_incoming->dev, if_incoming->addr_str,
-		orig_str, prev_sender_str, batman_packet->seqno,
-		batman_packet->tq, batman_packet->ttl, batman_packet->version,
-		has_directlink_flag);
+	bat_dbg(DBG_BATMAN, "Received BATMAN packet via NB: %pM, IF: %s [%s] (from OG: %pM, via prev OG: %pM, seqno %d, tq %d, TTL %d, V %d, IDF %d) \n",
+		ethhdr->h_source, if_incoming->dev, if_incoming->addr_str,
+		batman_packet->orig, batman_packet->prev_sender,
+		batman_packet->seqno, batman_packet->tq, batman_packet->ttl,
+		batman_packet->version, has_directlink_flag);
 
 	list_for_each_entry_rcu(batman_if, &if_list, list) {
 		if (batman_if->if_active != IF_ACTIVE)
@@ -428,13 +410,13 @@
 
 	if (is_my_addr) {
 		bat_dbg(DBG_BATMAN,
-			"Drop packet: received my own broadcast (sender: %s)\n",
-			neigh_str);
+			"Drop packet: received my own broadcast (sender: %pM)\n",
+			ethhdr->h_source);
 		return;
 	}
 
 	if (is_broadcast) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast source addr (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -471,7 +453,7 @@
 	}
 
 	if (is_my_oldorig) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -489,7 +471,7 @@
 	    !(compare_orig(batman_packet->orig, batman_packet->prev_sender)) &&
 	    (compare_orig(orig_node->router->addr,
 			  orig_node->router->orig_node->router->addr))) {
-		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %s) \n", neigh_str);
+		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast packets that may make me loop (sender: %pM) \n", ethhdr->h_source);
 		return;
 	}
 
@@ -636,14 +618,10 @@
 				   int result,
 				   struct batman_if *batman_if)
 {
-	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
 
-	addr_to_string(src_str, icmp_packet->orig);
-	addr_to_string(dst_str, icmp_packet->dst);
+	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", icmp_packet->orig, icmp_packet->dst);
 
-	printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
-
 	/* send TTL exceeded if packet is an echo request (traceroute) */
 	if (icmp_packet->msg_type != ECHO_REQUEST)
 		return;
@@ -739,7 +717,6 @@
 				struct batman_if *batman_if)
 {
 	struct unicast_packet *unicast_packet;
-	unsigned char src_str[ETH_STR_LEN], dst_str[ETH_STR_LEN];
 	struct orig_node *orig_node;
 	int hdr_size = sizeof(struct ethhdr) + sizeof(struct unicast_packet);
 
@@ -772,11 +749,8 @@
 
 	/* TTL exceeded */
 	if (unicast_packet->ttl < 2) {
-		addr_to_string(src_str, ((struct ethhdr *)
-					 (unicast_packet + 1))->h_source);
-		addr_to_string(dst_str, unicast_packet->dest);
-
-		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %s to %s: ttl exceeded\n", src_str, dst_str);
+		struct ethhdr * src = (struct ethhdr *) (unicast_packet + 1);
+		printk(KERN_WARNING "batman-adv:Warning - can't send packet from %pM to %pM: ttl exceeded\n", src->h_source, unicast_packet->dest);
 		return;
 	}
 
@@ -1027,7 +1001,7 @@
 	atomic_set(&exit_cond, 0);
 	packet_buff = kmalloc(PACKBUFF_SIZE, GFP_KERNEL);
 	if (!packet_buff) {
-		printk(KERN_ERR"batman-adv:Could allocate memory for the packet buffer. :(\n");
+		printk(KERN_ERR "batman-adv:Could allocate memory for the packet buffer. :(\n");
 		return -1;
 	}
 
Index: compat.h
===================================================================
--- compat.h	(revision 1490)
+++ compat.h	(working copy)
@@ -73,3 +73,8 @@
 	ret; \
 })
 #endif /* LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25) */
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 29)
+asmlinkage int bat_printk(const char *fmt, ...);
+#define printk bat_printk
+#endif
Index: main.h
===================================================================
--- main.h	(revision 1490)
+++ main.h	(working copy)
@@ -111,6 +111,7 @@
 #include <linux/workqueue.h>	/* workqueue */
 #include <net/sock.h>		/* struct sock */
 #include <linux/jiffies.h>
+#include <linux/list.h>
 #include "types.h"
 
 #ifndef REVISION_VERSION
Index: routing.h
===================================================================
--- routing.h	(revision 1490)
+++ routing.h	(working copy)
@@ -27,10 +27,10 @@
 void slide_own_bcast_window(struct batman_if *batman_if);
 void batman_data_ready(struct sock *sk, int len);
 int packet_recv_thread(void *data);
-void receive_bat_packet(struct ethhdr *ethhdr, 
-				struct batman_packet *batman_packet, 
-				unsigned char *hna_buff, int hna_buff_len, 
-				struct batman_if *if_incoming);
+void receive_bat_packet(struct ethhdr *ethhdr,
+                        struct batman_packet *batman_packet,
+                        unsigned char *hna_buff, int hna_buff_len,
+                        struct batman_if *if_incoming);
 void update_routes(struct orig_node *orig_node,
-				struct neigh_node *neigh_node,
-				unsigned char *hna_buff, int hna_buff_len);
+                   struct neigh_node *neigh_node,
+                   unsigned char *hna_buff, int hna_buff_len);
