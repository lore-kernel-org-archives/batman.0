Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 30 Mar 2016 10:00 +0200
Message-ID: <4506388.qOszBEsOk4@bentobox>
In-Reply-To: <56FB11B7.10103@t-online.de>
References: <56F5AF2F.6060904@t-online.de> <4605306.DPF6tJRphQ@sven-edge>
 <56FB11B7.10103@t-online.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart25163072.cJdtV9kPNX";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] No rebroadcast on mesh links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart25163072.cJdtV9kPNX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 30 March 2016 01:37:27 Roland Volkmann wrote:
[...]
> > And btw. it is not about the originator. It is handled in
> > batadv_send_outstanding_bcast_packet at the same place where you want to have
> > the no_rebroadcast check. no_rebroadcast in the patch we are talking [1,2]
> > about is currently just ignoring the num_bcasts of a hard-interface for some
> > situations (when forw_packet->skb->dev == hard_iface->net_dev).
> 
> Let's have a look to the source code. The interesting part is function 
> "static void batadv_send_outstanding_bcast_packet(struct work_struct 
> *work)" in file "send.c". There you will find

To what are you answering? At least not to my statement.

>      soft_iface = forw_packet->if_incoming->soft_iface;
> [...]
>      /* rebroadcast packet */
>      rcu_read_lock();
>      list_for_each_entry_rcu(hard_iface, &batadv_hardif_list, list) {
>          if (hard_iface->soft_iface != soft_iface)   /* !!! */
>              continue;
> 
>          if (forw_packet->num_packets >= hard_iface->num_bcasts)
>              continue;
> 
> The if-Statement marked with /* !!! */ results in "true", if 
> incoming-interface isn't identical to outgoing-interface. Because the 
> patch is included after this line, it is relevant for resending 
> broadcasts to the incoming interface only.

No, it isn't about the incoming or outgoing hard-interfaces. See Marek's reply.

> Here is an updated version of the patch as it is used in current master 
> branch of gluon matching batman-adv 2016.0:

Not sure why you sent some(tm) patch of a patch in this way when there is a
guideline how to correctly send them [1].

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/open-mesh/wiki/Contribute#Submitting-patches

--nextPart25163072.cJdtV9kPNX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW+4eAAAoJEF2HCgfBJntG4aUP/1lSA/wi4GhJN1xZH0pMJZb2
KPweoA3h81qS8NgtOhOOH6GcHSMCiZnir2BIRMsDigEaNLlZiBSGTt9OepuHrv7i
FyyLabBPk2RhIJkkgrshbVzScszfRP7fV/pNd0NuosUAVvy9GvMwXlfPiDiTn7Hh
c5bAj/HOTZcBFUVvnnTkxri9HD5DZHoaPhdgifv4i9nHbp575Q1rjFG7KmJ1nF6M
wREDGMErUlxbjE0xIMuylfjkf4jblzkZQ9xDv+463bIAf/zwmsdbncIXIVl7l7cI
UwfZ6mhewa0QKYzjzNEBsiyyKkvcVEF3CyhyMwMUPg6gMn+jcE0b75i5VCR6Ga6l
/C93LjZIao67guuCzLOmxMJa992Gr0wZLV63frCRQrH9XwDT2bP1UgH5XkxDBLf+
FSKT+k911rQjeA8/iI8cf5oOZ39ZEv9wMwL/C/2cfxE9Ad8hG1okaODlpp8NTPGL
aH0lbb2v7pgV1JrZfc+ISy7u5ZQ1sa7taBbhYgiXjwE7NIgWzidwojwWBV215qqm
SzCY2YFXKqyqfAR84FAqTsSSizI8cJDfMjF1Mp1xJToXWzKUknbJkXG7Kt0XEPs3
ZNuXWF7DO/BekIlOXMDRr7FkSmKIODR/dWd21ov9dqP6rhevgJNrc+E2mSp4BiAG
9/EgHVp+WzGBJSlr0RAy
=RP2n
-----END PGP SIGNATURE-----

--nextPart25163072.cJdtV9kPNX--

