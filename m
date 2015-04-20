Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 08:11:05 +0200
Message-ID: <7485969.uCYZbFXWmu@sven-edge>
In-Reply-To: <10750000.oymJvT72oN@voltaire>
References: <13114664.Eg4ODy7KEo@bentobox>
 <1429288461-26260-1-git-send-email-sven@narfation.org>
 <10750000.oymJvT72oN@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8410506.M2TC1lKe4t";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 1/6] batman-adv: ignore
	netdev_set_master() calls on kernels older than 2.6.39
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
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart8410506.M2TC1lKe4t
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 20 April 2015 11:32:23 Marek Lindner wrote:
> On Friday, April 17, 2015 18:34:16 Sven Eckelmann wrote:
> > From: Marek Lindner <mareklindner@neomailbox.ch>
> > 
> > batman-adv calls netdev_master_upper_dev_link() which is replaced with
> > with
> > netdev_set_master() for kernels older than 3.9 via compat.h.
> > Prior to 2.6.39 netdev_set_master() contained Linux bonding calls needed
> > to
> > setup bonding devices. Calling this function from batman-adv leads to
> > unexpected behavior when current batman-adv versions are used on these
> > older kernels.
> > 
> > To fix the situation compat.h now ships its own implementation of
> > netdev_set_master() which does not change the net_dev->master state
> > on kernels older than 2.6.39.
> > 
> > Reported-by: Andreas Pape <APape@phoenixcontact.com>
> > Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  compat.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> I have already cherry-picked that patch myself.

Depends on your definition of "already". It was not cherry-picked when I've 
sent this patch. The commit you are referring to was cherry-picked 25 minutes 
before you wrote this mail and my patch was send 5160 minutes before your 
mail.

Kind regard,s
	Sven
--nextPart8410506.M2TC1lKe4t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVNJh5AAoJEF2HCgfBJntGFZ4P/2bHi4JAmky1IezQKHy75roD
j4XbhHDsddtmwgd+MLif2XyCx5p+oHzcduaPyEunV9e44DxzZ2j9xir5SDsVgAdb
2X/PX7t/mbhfqdN5epYs+bhehFlzhNvjn9VO8pn9idFtUuJyrlkdKapnYp4Mj+xb
nw+hh0sNbKop9kXlnCeoXaJzl+aPMJRL97IIKvkwadA++Mq3uc5sgt6i/GyFUiKM
TPRot6cfP7Hrznqq4r+mwx2rn2dYh7LX8qE45sOalSGo0FU8ezc4zoclMmTadJcP
EBF+1NK9+f3G2P+wv3GuAaL9MfQ/y/F9AvJLTZqG11fkBugLM5tA3/H2hhO6Pyik
5Pimk6WOE9H5rPUegvHbHxk1ed7Dcvo+Yuv7Cb2f9J/6fJMghJKcSK5AjstD524c
g2cK6p6J5NayHve1x29EAZMe7WgGOhkhLblPdvultrslFMq+z5EjEH1d1/t+oCkQ
hdw4pNmQhXtkwA4T8ERiloA4eR7961lwK8/5Z3sZ8qqIBgnAL50HZIGJDQ+FypNr
y/VW5rVWtMGBO00t1ZPsCbwG/5NvwJOtoNUVk24HdRcLPFd7py1Zz3f8i69YtGey
rukbyXU/vpHDTNs6OQHYylwmgVF3oC9wjjs/WWC9ZHL2LhzDHQDj2gGnsIN0hCSv
CRuJyzA2JmGcVdb739uJ
=r98N
-----END PGP SIGNATURE-----

--nextPart8410506.M2TC1lKe4t--

