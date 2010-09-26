Return-Path: <lew.pitcher@digitalfreehold.ca>
From: Lew Pitcher <lew.pitcher@digitalfreehold.ca>
Date: Sun, 26 Sep 2010 15:16:16 -0400
References: <201009262057.36382.lindner_marek@yahoo.de>
	<1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1285527477-10340-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2919246.VuHoyJBvmj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201009261516.21774.lew.pitcher@digitalfreehold.ca>
Subject: Re: [B.A.T.M.A.N.] batman-adv: softif lan loop avoidance
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2919246.VuHoyJBvmj
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On September 26, 2010 14:57:56 Marek Lindner wrote:
> By connecting multiple batman-adv mesh nodes to the same LAN network
> an ethernet loop can be created when the soft-interface is bridged
> with the LAN interface. A simple visualization of the loop:
>
> node1 =A0<-- LAN =A0--> =A0node2
> =A0 =A0| =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> =A0wifi =A0<-- mesh --> =A0wifi
>
> This patch adds the functionality to detect other batman-adv nodes
> connected to the LAN and select a 'gateway' to talk to the
> non-batman-adv devices on this LAN. All traffic from and to the mesh
> will be handled by this gateway to avoid the loop. OGMs received via
> the soft-interface are interpreted as 'port announcements' to locate
> potential batman-adv nodes. The patch can also deal with vlans on
> top of batX and offers a list of LAN neighbors via debugfs.

Not meaning to "joggle your elbow" on this, and only for my own information=
=20
and education, I wonder if you could tell me why this approach was selected?

ISTM that, for this sort of loop,=20
  node1  <-- LAN  -->  node2
     |                   |
  wifi1  <-- mesh -->  wifi2
you are trying to prevent OGMs from perpetually circulating around.=20
Wouldn't "wifi1" be able to recognize it's own OGMs? If so, then why wouldn=
't=20
it just drop them, rather than passing them along to the next node?

If each wifi dropped it's own OGMs, then OGMs would only "circulate" once=20
through the loop, and be discarded when they arrive back at their originati=
ng=20
node.

Obviously, I don't understand enough about batman and batman-adv to be=20
critical of the design; I'm simply trying to understand how the design work=
s,=20
and why you chose the "gateway" approach to eliminate routing loops.

Thanks
=2D-=20
Lew Pitcher
Master Codewright & JOAT-in-training   | Registered Linux User #112576
Me: http://pitcher.digitalfreehold.ca/ | Just Linux: http://justlinux.ca/
=2D---------      Slackware - Because I know what I'm doing.         ------



--nextPart2919246.VuHoyJBvmj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Armoured with GnuPG

iEYEABECAAYFAkyfnAAACgkQagVFX4UWr65BGACeMCBFTuWbtG/5HD76CvS+Cx2d
/fMAnjvLqf/ow3ZOI6FZqXSLEG/lU8iC
=gUy8
-----END PGP SIGNATURE-----

--nextPart2919246.VuHoyJBvmj--
