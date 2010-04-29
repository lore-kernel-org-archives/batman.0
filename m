Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 30 Apr 2010 00:46:46 +0200
References: <201004291621.08579.sven.eckelmann@gmx.de>
	<1272550944-8522-2-git-send-email-sven.eckelmann@gmx.de>
	<20100429163429.GF3734@lunn.ch>
In-Reply-To: <20100429163429.GF3734@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11797275.OMIbSVxUmO";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201004300046.47608.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH-maint 2/2] batman-adv: Reduce max
	characters on a line to 80
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

--nextPart11797275.OMIbSVxUmO
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> > -		printk(KERN_ERR "batman-adv:Not using interface %s (retrying later):
> > interface not active\n", batman_if->dev); +		printk(KERN_ERR
> > "batman-adv:"
> > +		       "Not using interface %s (retrying later): "
> > +		       "interface not active\n", batman_if->dev);
>=20
> Here i would of probably broken the line after %s to keep the rest
> together.
>=20
> > @@ -281,8 +287,9 @@ ssize_t orig_fill_buffer_text(struct net_device
> > *net_dev, char *buff,
> >=20
> >  	if (!bat_priv->primary_if) {
> >  =09
> >  		if (off =3D=3D 0)
> >  	=09
> >  			return sprintf(buff,
> >=20
> > -				       "BATMAN mesh %s disabled - please specify interfaces to
> > enable it\n", -				       net_dev->name);
> > +				     "BATMAN mesh %s disabled - "
> > +				     "please specify interfaces to enable it\n",
> > +				     net_dev->name);
> >=20
> >  		return 0;
> >  =09
> >  	}
>=20
> How about combining to two if's into one, so reducing the indentation,
> and break the line after %s?

In this case it doesn't work because the line would be still to long.

>=20
> > @@ -290,7 +297,8 @@ ssize_t orig_fill_buffer_text(struct net_device
> > *net_dev, char *buff,
> >=20
> >  	if (bat_priv->primary_if->if_status !=3D IF_ACTIVE) {
> >  =09
> >  		if (off =3D=3D 0)
> >  	=09
> >  			return sprintf(buff,
> >=20
> > -				       "BATMAN mesh %s disabled - primary interface not active\n",
> > +				       "BATMAN mesh %s disabled - "
> > +				       "primary interface not active\n",
> >=20
> >  				       net_dev->name);
> >  	=09
> >  		return 0;
>=20
> Same again.

Changed

>=20
> > @@ -458,13 +469,16 @@ void receive_bat_packet(struct ethhdr *ethhdr,
> >=20
> >  	if (is_my_addr) {
> >  =09
> >  		bat_dbg(DBG_BATMAN,
> >=20
> > -			"Drop packet: received my own broadcast (sender: %pM)\n",
> > +			"Drop packet: received my own broadcast "
> > +			"(sender: %pM)\n",
>=20
> I know it probably looks a little odd, but maybe break before %pM so
> the constant text is whole?

Done=20

> >  	if (is_broadcast) {
> >=20
> > -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all packets with broadcast
> > source addr (sender: %pM)\n", ethhdr->h_source); +		bat_dbg(DBG_BATMAN,
> > "Drop packet: "
> > +		"ignoring all packets with broadcast source addr "
> > +		"(sender: %pM)\n", ethhdr->h_source);
>=20
> Same again?

Done

> >  	if (is_my_oldorig) {
> >=20
> > -		bat_dbg(DBG_BATMAN, "Drop packet: ignoring all rebroadcast echos
> > (sender: %pM)\n", ethhdr->h_source); +		bat_dbg(DBG_BATMAN,
> > +			"Drop packet: ignoring all rebroadcast echos "
> > +			"(sender: %pM)\n", ethhdr->h_source);
>=20
> Same again...

Doesn't fit

>=20
> >  		return;
> >  =09
> >  	}
> >=20
> > @@ -508,12 +525,15 @@ void receive_bat_packet(struct ethhdr *ethhdr,
> >=20
> >  	is_duplicate =3D count_real_packets(ethhdr, batman_packet, if_incomin=
g);
> >  =09
> >  	if (is_duplicate =3D=3D -1) {
> >=20
> > -		bat_dbg(DBG_BATMAN, "Drop packet: packet within seqno protection time
> > (sender: %pM)\n", ethhdr->h_source); +		bat_dbg(DBG_BATMAN,
> > +			"Drop packet: packet within seqno protection time "
> > +			"(sender: %pM)\n", ethhdr->h_source);
>=20
> Probably does not fit this time :-(

Correct, doesn't fit.

> > diff --git a/send.c b/send.c
> > index caec6ef..7f3031d 100644
> > --- a/send.c
> > +++ b/send.c
> > @@ -67,7 +67,8 @@ int send_skb_packet(struct sk_buff *skb,
> >=20
> >  	if (!(batman_if->net_dev->flags & IFF_UP)) {
> >  =09
> >  		printk(KERN_WARNING
> >=20
> > -		       "batman-adv:Interface %s is not up - can't send packet via th=
at
> > interface!\n", +		       "batman-adv:Interface %s is not up - "
> > +		       "can't send packet via that interface!\n",
>=20
> Maybe break after the %s?

Done

> >  	if (!bat_priv->primary_if) {
> >  =09
> >  		if (off =3D=3D 0)
> >  	=09
> >  			return sprintf(buff,
> >=20
> > -				       "BATMAN mesh %s disabled - please specify interfaces to
> > enable it\n", -				       net_dev->name);
> > +				     "BATMAN mesh %s disabled - "
> > +				     "please specify interfaces to enable it\n",
> > +				     net_dev->name);
> >=20
> >  		return 0;
>=20
> Combine the two ifs and break on the %s?

Still too long.

The rest of the patch was renewed and submitted as

[PATCH-trunk 2/2v2] batman-adv: Reduce max characters on a line to 80
[PATCH-maint 2/2v2] batman-adv: Reduce max characters on a line to 80

Best regards,
	Sven

--nextPart11797275.OMIbSVxUmO
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL2gxWAAoJEF2HCgfBJntGkaQQAJK6ZL0oiS690xLnAF5DRqVv
ELNfVcEHIQZZTKyPri0NcNG534xoOQV455VaZIZhP0VaL1vNXtNcIpEyN7o48Rfq
X1YtVrNCG1wF35jx3Q1+/tj/UW6eJ67B5WjUZ1xOlMXMLdhN6ABujzk+W+T/r58z
0uEzYw/Pq+xZS9cN5I3MRnfx8WrJBQlHSZIO3ET9c6OVplFC+Yl2OU41MT123fE5
v7855tUEve5D0dr2z+45osfYavWjwrtiQutHzuv5cY/k4Xbc6T67p+RytuF9hVyN
6zDD4EzDQ2MrIM8lSRcCdNXbuiHftozQWoBllkXbSaCzawvV8CSEaZr5+57jNaJw
lZeExoyTWWqzXslD1yvGNZm9wbof01Q834SCXVlFzpccLvUnH/MGLhBhwrEpeVlx
ESna1YDCBZGEQGQHie9Ny2LvnmYpkFA/Dsx1cDwyQoFthP2hqSaaD3V0x+/Rt8hG
knvm3a3f/9Sl2kZcuWcZ4vsKD+UXcnjOBEMNFgT+O31clYQXnxmJeUajxYziIf7X
nos7Q6X3TwHuLHz2LWLER4GY6dzody9tqRz5NWhGzGdIQ0WwfxtQLCxiM/alXKDr
OBG4qn74SXjOUWiEkOBmLTQaiPbSPxB3XdLEVnTw6SSckhL6ggpdRvvf/sMw6KPS
r+lnMA7jYsrxvDGjPRr9
=6R7y
-----END PGP SIGNATURE-----

--nextPart11797275.OMIbSVxUmO--
