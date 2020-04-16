Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: maximum hop count
Date: Thu, 16 Apr 2020 15:22:47 +0200
Message-ID: <10653471.RuQBq8sfPP@bentobox>
In-Reply-To: <db951dbb-7ec9-6938-faa7-bf2b46eeda30@web.de>
References: <db951dbb-7ec9-6938-faa7-bf2b46eeda30@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2123889.SXdxVlKeI9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart2123889.SXdxVlKeI9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 16 April 2020 14:26:14 CEST Moritz Warning wrote:
> Hi,
> 
> I run a simulation of 50 batman-adv instances connected on a chain topology:
> 
> [node-0] <-> [node1] <-> ... <-> [node49]
> 
> Despite there being no packet loss, the nodes at both ends (nodes 0 and 49) only see 32 other nodes.
> 
> The second outermost nodes see 33 other nodes and so on until the nodes that are at least 18 hops from both ends (nodes 17 and 32), which see all other 49 nodes.
> 
> The OGM TTL is set to 50 [1], but from this experiment, the TTL seems to be 32.
> 
> Can someone shed light on this observation?
> The batman-adv version used is 2019.4.


[2020-04-04 15:13:28] <mwarning> does batman-adv has a maximum hop count? (given that there is no packet loss)
[2020-04-04 15:13:54] <mwarning> I get some funny results while testing with a lot of nodes in a line.
[2020-04-04 16:21:16] <hexa-> hop_penalty gets subtracted from the tq on each hop, so yes
[2020-04-04 17:23:46] <T_X> also, the OGM TTL is 50 (in case mwarning comes back and someone wants to tell him)
[2020-04-04 17:23:49] <T_X> https://git.open-mesh.org/batman-adv.git/blob/refs/heads/master:/net/batman-adv/main.h#l26
[2020-04-04 22:17:02] <marec> mwarning: <T_X> also, the OGM TTL is 50 (in case mwarning comes back and someone wants to tell him)
[2020-04-04 22:17:09] <marec> mwarning: <T_X> https://git.open-mesh.org/batman-adv.git/blob/refs/heads/master:/net/batman-adv/main.h#l26
[2020-04-04 22:20:11] <mwarning> ah
[2020-04-04 22:20:17] <mwarning> marec: thanks
[2020-04-04 22:21:50] <mwarning> https://mwarning.de/misc/convergence-line.png
[2020-04-04 22:22:24] <mwarning> ^ I was worried because batman-adv didn't reach 100% in this artificial test of 100 nodes in line
[2020-04-04 22:24:53] <mwarning> T_X: thanks
[2020-04-04 22:25:36] <mwarning> is there a technical reason for it to be set to 50? Or is it just high enough for technical reasons?
[2020-04-04 22:25:52] <mwarning> * high enough for practical reasons
[2020-04-04 22:35:21] <ordex> mwarning: I think nobody ever came up with a real use case where 50 was not enough
[2020-04-04 22:35:50] <ordex> due to hop penalty and natural metric reduction, a path will most likely never reach 50 hops
[2020-04-04 22:36:33] <mwarning> true (over wifi)
[2020-04-04 22:36:49] <mwarning> a lattice of 100 nodes is much better: https://mwarning.de/misc/convergence-lattice4.png
[2020-04-05 01:08:04] <marec> mwarning: feel free to propose a patch increasing the TTL on the ml
[2020-04-05 01:08:22] <marec> if you feel a bigger TTL is worthwhile
[2020-04-05 01:16:48] <mwarning> I doubt it is worthwhile. That one test was artifical.
[2020-04-05 01:17:45] <mwarning> I will test batman-adv with 1000 nodes tomorrow. But on a lattice.
[2020-04-05 01:18:24] <mwarning> (and if the server can handle the load)
[2020-04-05 11:08:01] <ordex> mwarning: but it seems batman-adv eventually manages to deliver to every node, right ?
[2020-04-05 11:08:07] <ordex> so there is no reachability problem apparently ?


Also regarding the hop penalty - let us the TQ after these amount of hops 
(really, really, really simplified):

  >>> 255 * ((255 - 30) / 255.) ** 32
  4.646168821433396


Now do the same with integer math:

	 def new_tq_penalty(tq):
	 	 hop_penalty = 30
	 	 BATADV_TQ_MAX_VALUE = 255
	     
	 	 new_tq = tq * (BATADV_TQ_MAX_VALUE - hop_penalty);
	 	 new_tq /= BATADV_TQ_MAX_VALUE;
	     
	 	 return int(new_tq)
	 
	 tq = 255
	 for i in range(32):
	     tq = new_tq_penalty(tq)

	 print(tq)

And even in a perfect scenario, you would only have a tq of 0. And here we 
even ignored that wifi interfaces which are used as incoming and outgoing 
interfaces have an extra round of penalty for each link.

Originator nodes with a TQ of zero are filtered out [1] during the print and 
are also not forwarded [2].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/e13bcb6db03b74e1eb77e7410761db6eca25d48e:/net/batman-adv/bat_iv_ogm.c#l1849
[2] https://git.open-mesh.org/batman-adv.git/blob/e13bcb6db03b74e1eb77e7410761db6eca25d48e:/net/batman-adv/bat_iv_ogm.c#l1357
--nextPart2123889.SXdxVlKeI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6YXCcACgkQXYcKB8Em
e0Zf2g//VKlIgsp6Ho0fZwBtOjjKPjkzQ1heSjkQ4McnOilgei/I5VBB7kiN2xrC
pYKRT09tOoaCG5PoJteKGQoTuyoefHWoxJ4H1t2H7SgwiRhfwQPXmeT+Q6KrgQdG
xqY2osYbuTTCoLikSu1cz0/EWb3GmEYEb/ckL0id0NT+spcR4u88Z+Kh0tnh9VVv
hdFBlWIwqe5bhH0K2W1xgPGIN1RRVrYTFbP8DTvZqGLHFQIBYJDimef2Ru1UnJFf
csbqa8LHyHP0CFNLw1czLG/FSdSkipr0Gax3Z66HRDKCdGkw+aTfW3Oj9J1wAyVX
O9uFxIfcxt5oEyGhuMf+4gl6a2ygBQqE1OAPevVOpgsNW5sLZnQZPok7o3fOva00
nS42iIfGOna8WQxEl1sLe3MXb93FrrkZwYiPBmvhEhPAKblgd6vOP8OZDKhPDveT
KhbrJBdTn0iOEHn/RD4Kjjc1vBVn2HMyOveU+XwPHbnofL2m7zZhVtfo6/bQPVSz
3T7d4oyB6vsLPl/4MHvkdIbbWiridr4FhLihYr7Rxb7EktMu7YyeQQPoF2O/NIn2
HCMMxZ7IehXiaWwvTZgIxYOb5SoMGeKPDfjlRG3p3tagQ0PBxrwqj3iQHHUsInvL
cEs7J4QKB+yB21cD9gE5O6hggVLRS9eVJc3Mo3OE0ynQIwS8RDU=
=Hhmn
-----END PGP SIGNATURE-----

--nextPart2123889.SXdxVlKeI9--



