Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 23 Sep 2013 10:18:27 +0200
Message-ID: <4148310.CdzoCJI8ee@bentobox>
In-Reply-To: <20130923070342.GF3911@neomailbox.net>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
 <20130923070342.GF3911@neomailbox.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart20003297.eKOsgGU0Ko";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Add missing includes and
	remove unused includes
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
To: Antonio Quartulli <antonio@meshcoding.com>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart20003297.eKOsgGU0Ko
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 23 September 2013 09:03:42 Antonio Quartulli wrote:
> > -#include <stdio.h>
> > 
> >  #include <stdint.h>
> > 
> > +#include <stdio.h>
> 
> why is it important to move stdio.h below stdint.h ? Is there a particular
> reason for that?

No, just an artifact of the work on the includes. But now it is an 
alphabetical order (at least these two items)... so it is extremely important 
:D

Kind regards,
	Sven
--nextPart20003297.eKOsgGU0Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAABCgAGBQJSP/lTAAoJEF2HCgfBJntGIJAP/1rlVT5lalrn81M3g6iZWg5C
gSCuNRhlTWKFznT97ISzRQ38Nnn3MFw52CJrS4fpENSKJXQgz/CF0fBODmZSJ6uN
SP+GzCmG5CQmAM1QGxOaAoZ8DHjEQUM/PwXe5haeRTm1EMamMqXgdy8c+6ULah8y
UT3Zpf92cQi4v74T7tusgJRDujU5CT7sNrILwKGWatozydmcJ118hcG5hxsl5Y8Y
xOTSou79i5Bc4eBn+QY3Xdlag1CdkwHI5P+VYuOBTZ9giVLUyze70P1Ul8AvVkB9
M7D5ivB6nvd31MB/SNKRLeG1b5pPXRcgzomyMJokQ6042g5No2ejIeJB+AjgZGiW
wTDEK1XKkApCaQw2F7cvXYsU4IoxDzP27DmEV3Z/4VSZenAwMQKtFzXixOJ92lkB
nU+HAT88p6lFhZcfbcWVG4+ekerOr31CmcrD+6UcPzlCobpCt+v8mgwuFdvOjLZG
hlEUmHBk8YwE+NDWfNmJm+WPehwLABsvOLV7cj2EBryMTemm6mnbGbtGOvLIexbb
VsFAnExUew7g68CjsGX8+HFTnHTo+AsNYijO6lRIXov9fdGk7IdwCPQHoPKbQF17
Y04g8g+dOB3vHE/tjgI+84c+40rBL5VE41kbLDH4vAckSM9pu+Sjx6iW80zboM3Q
x5xJKqshr0o6MO9Uneg5
=f2jY
-----END PGP SIGNATURE-----

--nextPart20003297.eKOsgGU0Ko--

