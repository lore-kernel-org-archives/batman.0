Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 17 Nov 2011 21:01:11 +0100
Message-ID: <25416217.yBclFAKIz7@sven-laptop.home.narfation.org>
In-Reply-To: <CAG7VhQTrx1nvuH2ZXRbenSuwAqE7RyW=r9WoWrH+ubs6+aP56g@mail.gmail.com>
References: <CAG7VhQTrx1nvuH2ZXRbenSuwAqE7RyW=r9WoWrH+ubs6+aP56g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3544657.nVJKRu7qJd";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/5] Loop-freness for B.A.T.M.A.N.
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3544657.nVJKRu7qJd
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="windows-1252"

On Thursday 17 November 2011 16:15:42 Daniele Furlan wrote:
> This series of patches introduce a correction in tq metric and forwarding
>  rules of ogm packets.
> 
>  In the current configuration routing loops scenario can emerge due to some
>  conceptual errors such the global tq window and the forwarding of ogm
> coming from sub-optimal paths substituting ogm tq with the average of
> current router. An example scenario has been realized also in simulation
> using qemu.

Interesting statement but maybe it would also be interesting for others to
provide examples and explanations.

>  Can be demonstrated as already done for DSDV[1], that is a protocol very
>  similar to batman, that a proper forwarding policy together with a strict
>  control on metric monotonicity (as suggested in [2]) are sufficient to
>  guarantee loop-freeness for the protocol.
> 
>  I apologize in advance if the source style is not the best possible,
>  but I hope that the ideas will applied after a phase of code revision.

Please read and understand
 http://www.open-mesh.org/wiki/open-mesh/Contribute#Submitting-patches

I refer here to checking of your patches using simple static analyzers and the
documentation part.

Also things like

+               /* update last originator seqno received from this neighbour */
+               if ((set_mark) && 
+                       (batman_ogm_packet->seqno > tmp_neigh_node->last_seqno))
+                       tmp_neigh_node->last_seqno = batman_ogm_packet->seqno;
+

are simply wrong. Have you thought about overflow of sequence numbers (hint:
seq_before/after)? Ok, forget about the code and look at the rest.

You don't give any hints about implications of your changes in the commit
messages (no, something like "everything will be better because I say it"
doesn't count).

Take for example the stuff prepared by Simon. He gathered information, talked
to the people and prepared documentation. I can now use this stuff to discuss
with him at a higher level than with the stuff you provided. And his stuff is
only a "small" optional feature, but your patches changes things in the path
selection and information propagation code.

Maybe you should contact everyone (marec, d0tslash, ordex, ...) on IRC and
talk about the actual concepts (and also their concepts... ttvn
*hinthinthint*) and prepare actual documentation based on that.

Kind regards,
	Sven
--nextPart3544657.nVJKRu7qJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOxWgHAAoJEF2HCgfBJntGj6cQAK+9NsJghGV4d8wE9J54g2mb
g+tVkXhUhP5ZBYI4AdXUMbW7TN8mNoO88vDcFWrpS/47hGJpzO/srT8i0/1zeSCN
FccNoEh2pkCxPT1uZo+VAX5FEFM0L1ZEctQ5IGz2VAbwA/iZIfb2KlhTDBy6gqAF
cFXOc3OtabVwpRTr+z4f1N84LyvpcjxttbOL1a+PdgiSbEF8ZaThBlfiPy6SjSPG
HFJE8jt/XTIuGwKU/rwbIEnhGgnxi5GyKtqdAP27rgJfyfoYmW7BF2OTad+uOLPD
5CKWGjDmE0F7K1nV9FqBjfa1fHB96cVCdVm5ffTrHQdpsxTAUd8OGV1fo2cqu+yp
0WfUGHbNn5QsdDaA9bfF9kcLCNAVxHtg/4APqs9PS7fLUMYRFKWJXRD9i5/3tyRF
RaLPw3/EQdSUffosoYbHboHC+R+gzDZIkBZ0AAUZiWkRdlObRvFJaw8FRhPfER75
yK66iJBx6YDsqmmA5ixFrWCbu7+iWlFRjapZ8KSevMN38aDqg2rcpncaxAK+VrYo
EEXkwX8KHJvXH1ChiZhBgHHVoKTjx7cno3jvYHCIU49d2gTZP3rSkFSzH0fk2nao
P6/9o/y12Fddg/vk4hMaQZH4TUVFXfbtX00izd1SO+iWUyv6S+TdH8X3fR4MhHtG
xe0xwJSE3+aHhVybBHPS
=ANq9
-----END PGP SIGNATURE-----

--nextPart3544657.nVJKRu7qJd--

