Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417456897.2788.2.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Mon, 01 Dec 2014 19:01:37 +0100
In-Reply-To: <1417388720-5019-1-git-send-email-sven@narfation.org>
References: <1417388720-5019-1-git-send-email-sven@narfation.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-JqChEi1KlM28i+sJr2w4"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Calculate extra tail size
 based on queued fragments
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: batman-ml <b.a.t.m.a.n@lists.open-mesh.org>
Cc: martin@hundeboll.net, sven@narfation.org


--=-JqChEi1KlM28i+sJr2w4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin, hi Sven, hi all

Thank you very much for analysing, describing and hacking on our issue.
I=E2=80=99m sorry to ruin your other thread Sven ;-)

You are asking about our set-up in other threads. To save you from
reading the commands I posted for Martin, let me make a quick draw:

This bug posted here:=20
                     _________                                      User
                     |  NAT  |                     |------------|   on
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> |  VM   | <=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> | Mesh-Nodes |<--AP
                     |_______|                     |____________|   MTU
ipip-Tunnel to our VM   NAT  bat15 over fastd-Tunnel   ^           1500
which is connected to         1:n to meshing nodes     | NC-disabled
       our ISP                                         | bat15-Link to
  MTU 1400 is set to         default fastd MTU 1426    | other nodes
 reproduce the bug of                                  | wrong MTU 1528
    the other VMs                                      |  [from bat14]
 no batman involved in                                 |(will be changed
    this tunnel                                        |  to 1560 with=20
                                                       | next firmware)


On the other VMs, I can't analyse the bug, there is a GRE-tunnel to ISPs
routers with fixed MTU of 1400. Over these tunnels there are no batman
packages sent through. Only IPv4 and IPv6. The VM do the NAT to a public
IP.

I=E2=80=99m sorry making you such a mess with the MTU. Nowadays many commun=
itys
do an outsourcing of the gateways to the internet. They provide more
throughput and a coherent batman cloud if there are white spaces without
nodes on the map.

I=E2=80=99d like to inform you that I implement the patch posted with this =
mail
18 h ago. It is a mix of the patch Martin gave me earlier and your 1st
patch from =E2=80=9CCalculate extra tail size based on queued fragments=E2=
=80=9D. There
was no crash, but this means nothing. Now I see, there are many, many
patches which solves the bug with different approaches. Please tell me
exactly which one I should test because I don't speak any C.

Best regards and happy hacking

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93



# batctl -v
batctl 2014.3.0 [batman-adv: 2014.3.0-44-g650251a-dirty]

diff --git a/fragmentation.c b/fragmentation.c
index 362e91a..743d0d3 100644
--- a/fragmentation.c
+++ b/fragmentation.c
@@ -217,6 +217,18 @@ err:
 	return ret;
 }
=20
+static inline void batadv_frag_dbg_entry(struct batadv_frag_list_entry *en=
try)
+{
+	struct sk_buff *skb =3D entry->skb;
+	struct batadv_frag_packet *packet;
+
+	packet =3D (struct batadv_frag_packet *)skb->data;
+
+	printk(KERN_DEBUG "  skb->len: %u, skb->tailroom: %u, pkt->pkt_type: %hhu=
, pkt->version: %hhu, pkt->no: %hhu, pkt->seqno: %hu, pkt->total_size: %hu\=
n",
+	      skb->len, skb_tailroom(skb), packet->packet_type, packet->version,
+	      packet->no, ntohs(packet->seqno), ntohs(packet->total_size));
+}
+
 /**
  * batadv_frag_merge_packets - merge a chain of fragments
  * @chain: head of chain with fragments
@@ -228,18 +240,14 @@ err:
  * Returns the merged skb or NULL on error.
  */
 static struct sk_buff *
-batadv_frag_merge_packets(struct hlist_head *chain, struct sk_buff *skb)
+batadv_frag_merge_packets(struct hlist_head *chain)
 {
 	struct batadv_frag_packet *packet;
-	struct batadv_frag_list_entry *entry;
+	struct batadv_frag_list_entry *entry, dbg_entry;
+	struct batadv_frag_table_entry *table_entry;
 	struct sk_buff *skb_out =3D NULL;
-	int size, hdr_size =3D sizeof(struct batadv_frag_packet);
-
-	/* Make sure incoming skb has non-bogus data. */
-	packet =3D (struct batadv_frag_packet *)skb->data;
-	size =3D ntohs(packet->total_size);
-	if (size > batadv_frag_size_limit())
-		goto free;
+	int size, hdr_size =3D sizeof(struct batadv_frag_packet), i =3D 0;
+	int extra_tail;
=20
 	/* Remove first entry, as this is the destination for the rest of the
 	 * fragments.
@@ -247,13 +255,26 @@ batadv_frag_merge_packets(struct hlist_head *chain, s=
truct sk_buff *skb)
 	entry =3D hlist_entry(chain->first, struct batadv_frag_list_entry, list);
 	hlist_del(&entry->list);
 	skb_out =3D entry->skb;
+	memcpy(&dbg_entry, entry, sizeof(dbg_entry));
 	kfree(entry);
=20
+//	if (size < skb->len)
+//		goto debug;
+//
+//	if (size < skb_out->len)
+//		goto debug;
+//
+	packet =3D (struct batadv_frag_packet *)skb_out->data;
+	size =3D ntohs(packet->total_size);
+
 	/* Make room for the rest of the fragments. */
-	if (pskb_expand_head(skb_out, 0, size - skb->len, GFP_ATOMIC) < 0) {
-		kfree_skb(skb_out);
-		skb_out =3D NULL;
-		goto free;
+	if (size > skb_out->len) {
+		extra_tail =3D size - skb_out->len;
+		if (pskb_expand_head(skb_out, 0, extra_tail, GFP_ATOMIC) < 0) {
+			kfree_skb(skb_out);
+			skb_out =3D NULL;
+			goto free;
+		}
 	}
=20
 	/* Move the existing MAC header to just before the payload. (Override
@@ -268,6 +289,11 @@ batadv_frag_merge_packets(struct hlist_head *chain, st=
ruct sk_buff *skb)
 	/* Copy the payload of the each fragment into the last skb */
 	hlist_for_each_entry(entry, chain, list) {
 		size =3D entry->skb->len - hdr_size;
+		i++;
+
+		if (skb_tailroom(skb_out) < size)
+			goto debug;
+
 		memcpy(skb_put(skb_out, size), entry->skb->data + hdr_size,
 		       size);
 	}
@@ -276,6 +302,19 @@ free:
 	/* Locking is not needed, because 'chain' is not part of any orig. */
 	batadv_frag_clear_chain(chain);
 	return skb_out;
+
+debug:
+	table_entry =3D container_of(chain, struct batadv_frag_table_entry, head)=
;
+	printk(KERN_DEBUG "batadv_frag_merge_packets: i: %i, size: %i, entry->seq=
no: %hu, entry->size: %hu, entry->total_size: %hu\n",
+	       i, size, table_entry->seqno, table_entry->size,
+	       table_entry->total_size);
+	batadv_frag_dbg_entry(&dbg_entry);
+
+	hlist_for_each_entry(entry, chain, list)
+		batadv_frag_dbg_entry(entry);
+
+	batadv_frag_clear_chain(chain);
+	return NULL;
 }
=20
 /**
@@ -304,7 +343,7 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (hlist_empty(&head))
 		goto out;
=20
-	skb_out =3D batadv_frag_merge_packets(&head, *skb);
+	skb_out =3D batadv_frag_merge_packets(&head);
 	if (!skb_out)
 		goto out_err;
=20
diff --git a/types.h b/types.h
index 462a70c..c4d7d24 100644
--- a/types.h
+++ b/types.h
@@ -132,6 +132,7 @@ struct batadv_orig_ifinfo {
  * @timestamp: time (jiffie) of last received fragment
  * @seqno: sequence number of the fragments in the list
  * @size: accumulated size of packets in list
+ * @total_size: expected size of the assembled packet
  */
 struct batadv_frag_table_entry {
 	struct hlist_head head;
@@ -139,6 +140,7 @@ struct batadv_frag_table_entry {
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
=20
 /**





--=-JqChEi1KlM28i+sJr2w4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUfK0HAAoJENpWdD1eHU4JAhwP/0fN4B53ij4CCBfulbwTeMFt
jLdeyc8insA2zwxswLhQb6luoEsDlXKtwYXdOUxlc3r0BkRgc5NfuO4twTpdEmwm
RQdDtdyXjoMQVEvhAETVQWXaAHXpwSfm59gFOcOvrBSwj0gKlFvtN1h0tXVV9LBc
eYxfxZkL4mspi4emqFckVroJOX366F1S3EjQdcEpZtRvpdZgEZvDIAwlANAZBc5w
QazzIKljXliCq4AfGotnNXBEQPOUloKzxO2GX52yJ9MU01wbfuNPIYopHABw1il9
xIBnlwy0OBeMQ57Vydn942A4OcR8yWUTpOzdwYlaB7POow6RJgdQ9kxw7FBaMbbz
EwTZ+BIgYvMXB+Baqn42m6OC0LQHefyrAXiScbTI/pQKat7d5m2/tnNQNeshJW3C
Hdq8lsGRgdkMUykR8yXLQs1jFR278TH/9eQIqqTkEV6xImawXhW6WTUDiVq1in+0
8Y/qHd+hlUk5tL+JKKI5HMm/F9OYv3bFtqORSzQ4sl0TxZNQvc7LYpgEe3ssCOdE
KeN2Kpf0rX6lkLIDr1IxUbj9OMENFmH8zVAYpnGvAZuvkWiLz1v8i9cvh0bsn6e4
4L6jPXG7ZgeOyA8ktQBxx/pavFRL2pld1Jp6JVYY2qJvPcFxuwuEQPYF2xVF+YcU
6bZY6TdDfKXmYTwile6G
=xadK
-----END PGP SIGNATURE-----

--=-JqChEi1KlM28i+sJr2w4--

