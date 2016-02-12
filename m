Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Feb 2016 16:49:43 +0100
Message-ID: <2101716.myXYXnb4kA@sven-edge>
In-Reply-To: <20160212152536.GA13273@lunn.ch>
References: <1455225357-15756-1-git-send-email-sven@narfation.org>
 <20160212152536.GA13273@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart69301355.bJGNNnmCy5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint v2] batman-adv: Avoid endless loop
	in bat-on-bat netdevice check
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

--nextPart69301355.bJGNNnmCy5
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 12 February 2016 16:25:36 Andrew Lunn wrote:
> >  /**
> > 
> > + * batadv_mutual_parents - check if two devices are each others parent
> > + * @dev1: 1st net_device
> > + * @dev2: 2nd net_device
> > + *
> > + * veth devices come in pairs and each is the parent of the other!
> > + *
> > + * Return: true if the devices are each others parent, otherwise false
> > + */
> > +static bool batadv_mutual_parents(const struct net_device *dev1,
> > +				  const struct net_device *dev2)
> > +{
> > +	int dev1_parent_iflink = dev_get_iflink(dev1);
> > +	int dev2_parent_iflink = dev_get_iflink(dev2);
> > +
> > +	if (!dev1_parent_iflink || !dev2_parent_iflink)
> > +		return false;
> > +
> > +	return (dev1_parent_iflink == dev2->ifindex) &&
> > +	       (dev2_parent_iflink == dev1->ifindex);
> > +}
> 
> Hi Sven, et al,
> 
> So this is fine for the non netns case.

This basically has nothing to do with your original patchset. It is only to 
fix the problem reported some time ago and nothing else. I have extracted this 
part of the patch only because you suggested this approach and Antonio wanted 
to submit it to net.git

Lets discuss the rest in the correct thread.

Kind regards,
	Sven
--nextPart69301355.bJGNNnmCy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWvf8XAAoJEF2HCgfBJntGtCUP/2SdAGKtR6m7IxbfKkVXGAy2
GtERvLc9Mg0/wjwj3vsFHurDzsufEA+sFHX0BH7/1kfNItmesoKAoKOcMFosa/1M
+sY/zv/bamwVCJz/PSCw6EASL8vU5A2scPo0JMcTCpDlmU6Di4vCDszNK/J6um8u
Zk6V0iorXC10eptDnW3L0W93ibN84zvzQX28UpJFtGcRmgO11XTurnXEgi9urO5P
59l4qqPWW/UvO/XNMMPW7IXNlaINXMpYutaH51Mut9DsUZzNi9RPAdDrHiFQZj4j
dEpcK/A7HiKpauFmEID/1LiNSlyqiji4ZWS6nXRTBuV/ymrOgiiuL9xVWuG/0vGw
AiFgqZby4NsFDJ0fl9AKBb0540OzxuSTLreuIyPt2UmjH1eDFlxaRsV9z9U+D0Hc
feX/4LCvSv4QlqGxotU0hLLUi4ujMXWa4/TQkUYSd2PQkHb/QFvs9c4L6SYBzlEr
TskHkSCnSR3wiZIL2ZN4yueXUOU9gus3m2xwboO2rlhScqWgmqpTPy6QwqGVGIP3
ziOqSSvIBt5xqbAi65kcSDobd9Gs5wohcQVfMGHgcKuLnZ3qAP0Wbdg1SqTqC9Ty
bZ1pfm72evnnwixEpK1D9otZxlMMVCyF+OYOiTru4jWIfyT1GrLWUaE/hqAv+ORJ
211se4Oz0o8marmsTSQA
=xbc0
-----END PGP SIGNATURE-----

--nextPart69301355.bJGNNnmCy5--

