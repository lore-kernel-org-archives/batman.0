Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 25 Nov 2011 09:54:08 +0100
Message-ID: <3481089.0jtDLCaObl@sven-laptop.home.narfation.org>
In-Reply-To: <20111125081820.GD6836@lunn.ch>
References: <1322173279-18338-1-git-send-email-ordex@autistici.org>
	<1322173279-18338-2-git-send-email-ordex@autistici.org>
	<20111125081820.GD6836@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11112604.7vGqrMEMhn";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 1/7] batman-adv: implement an helper
	function to forge unicast packets
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


--nextPart11112604.7vGqrMEMhn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 25 November 2011 09:18:20 Andrew Lunn wrote:
[...]
> > +	unicast_packet = (struct unicast_packet *)skb->data;
> > +
> > +	unicast_packet->header.version = COMPAT_VERSION;
> > +	/* batman packet type: unicast */
> > +	unicast_packet->header.packet_type = BAT_UNICAST;
> > +	/* set unicast ttl */
> > +	unicast_packet->header.ttl = TTL;
> 
> When Sven added this header structure, did he also add a function to
> fill it in?

No, I didn't. The header structure part was just the "keep it safe" thing. The 
fancy stuff can come later. And I am not sure whether such a function would be 
useful. More interesting would be the TTL cleanup that Linus proposed a long 
time ago.

Kind regards,
	Sven
--nextPart11112604.7vGqrMEMhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOz1ewAAoJEF2HCgfBJntGKswQAJJGQXaQC4CBklAoXPW0DguT
HVWw92QoWRkiJiMvbDen29NFtAqI5L7XiA1OmcmFHQvm6tBs86iVIOPdCFQzaeA5
mH1GPUue5AE+XxOMXYuWmIZ3sHHFVgHnJpHqYsoxtnNMoXTAnnGnMXskxN2kNF3T
X0IHOPsJgWwovq6cEtOWxwDrMWrWT1q6LiPqq/HuWd9yya6i+8HqmYOH+vMnaGz7
HPEqDn1PvPx8Qgr2x2srJh4xLwoNOvNTXkGnxxwPeXwjxeerBBW+uLdkO1HWb+VC
ufZGo1nTzDuNX3MnNgjSTP21fmi+u07risv2hvOVggIORIe+lKCc7WqTSHBwxMLN
Rgao4LQE9GsRs+jFXVMr8nenNoSLt4t0SP4oQJqD+x4GdVe2j0SXvoN1nWgq7wEW
CbMXGm2ulhtEv2DkubVKJ0MvKkFTGEGlbZHhDYK9k13JEHcy6Z2eaJbecHaQY7Fv
ZKkUG9jMQ5FvPNfkTwBONhbLukZVvn4a5W6NQdwGA2Hc+ff2mrmQtiTg4uXxAhny
e4Vc8BJTl6u0QC1oWVEg79D+fm28nvdsc6WQlNWtRl1C18srxls9lWpZO3TXLG7P
RDbKayzCy/fERzUj9+XDfFBS0LsjX9crBoOnkwVU1zpq21uMuRoMfMT4t9L/Oh+H
8ZtiOU/MSyNnB+FFllWR
=iIie
-----END PGP SIGNATURE-----

--nextPart11112604.7vGqrMEMhn--

