Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 14 Mar 2016 16:56:57 +0100
Message-ID: <58321025.0PBgHVCilp@bentobox>
In-Reply-To: <20160314140624.GA5636@lunn.ch>
References: <3465881.llCNFeNLl4@sven-edge> <15512323.RRrA1BdBoh@bentobox>
 <20160314140624.GA5636@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart45563779.867eWLcMxK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v3 6/6] batman-adv: debugfs: Add netns
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart45563779.867eWLcMxK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 14 March 2016 15:06:24 Andrew Lunn wrote:
> > Matthias is against applying [1] patch 6 because it would require that
> > batman-adv supports this interface for a long(tm) time. He proposes to use
> > netlink instead.
> > 
> > Andrew, do you want to change patch 6 to avoid creating the debugfs stuff in
> > non-init_net netns?
> 
> I'm not sure how well that is going to work, from the user space side
> of things.
> 
> In the kernel, we know if we are in init_net, or some other netns.
> 
> In user space, it is not so simple. Ideally, when in some other netns
> than the default, we need all reads/writes to debugfs to fail.

Hm, this would require some checks via the the current pid on open:

    net = get_net_ns_by_pid(current->pid);
    ... checky check via neteq(net, &init_net)...
    put_net(pd->net);

> What we
> don't want is it seeing the default name spaces files, because it is
> going to get very confusing. These files refer to something which does
> not exist in the current netns.

Wait, but thats exactly what you are doing already with your default behavior
(which only creates a symlink to netns/${FUNNY_ID}/. Legacy tools will still
read the wrong information because they don't know about the new netns paths.

I thought that the debugfs stuff will be replaced with netlink  and that the
current debugfs files are only there for non-namespace setups with legacy tools.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/4965/
--nextPart45563779.867eWLcMxK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5t9JAAoJEF2HCgfBJntG2VIP/2Bb9CT/NTuI8+GfcpNT2OMf
41duaqmtdkAXRz1Pdw3Gy0MQw0OMcUdfUzqOqO0DGldMdO60FKnb0ET6179vmUnQ
rDY8SDMxOnA/UTPylRP41N7ZFRMnfotvrrk3ho4iVXLNvt9pRS7gjoviPVD9q2i2
9NR+Ue5lt3Y6EMDex1io5bmnKVpnZoTgq4hl1fifjJ48q0C6dNny2oPfVuiDULjQ
jtA2zcZFDJqVnzg9Ge9IsRx5Pyed39SHwfN9/14jG+tdIjqc1VmOxJYg+QP4Q2Ca
MrvWncXlI0spvixrPtqFFaIvYicbTTjWsRjxvrJOiS7XVvmLApkZYyy+zFHuNJtn
4VrfYG70ZQ3qXQUgaQKNnGiY7NT57cu6s4wBtxxeZHnPaZNJ6rxu7bPr7B3KRnry
bVzd4CTqXJtwMdnsJRQOfBqZTWHBsHfL5dAYnczmH9pyRBZ/tujRefFQa57jH8wy
8z7RG3fJi42YM3znhlxL7VWZpt25xOaNZ4ZvCuKWvhmgON96WBOYeTVe0EWm5OBI
XSI6UWrsf2PRsGAWVTIT6E8WZKiADmIU6qTPyBkKKfOT5U0zwNAaDqxz5VWqbmK2
6oR+fvbRh4QHNrfSLa8Wq7lgxan9KhnXHxPmoVY+tf25jN2/HX7LqxCf9Qq9aiEk
8yjlinsef/Gck2BT30kR
=pqdb
-----END PGP SIGNATURE-----

--nextPart45563779.867eWLcMxK--

