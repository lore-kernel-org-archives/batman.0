Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 28 Jul 2016 20:18:38 +0200
Message-ID: <5348242.OI0toffihS@sven-edge>
In-Reply-To: <1469729158.5505.10.camel@c00941>
References: <1469726363.5505.7.camel@c00941> <31954371.21uiIYPYc7@sven-edge>
 <1469729158.5505.10.camel@c00941>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3821250.YiRq1gnyoo";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Externalizing ALFRED_INTERVAL
	for setting synchronization interval
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3821250.YiRq1gnyoo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 28. Juli 2016 18:05:59 CEST Jonathan Haws wrote:
> I've never used send-email.  I'll do some digging, learn it, and
> resubmit.

I would recommend to use msmtp to communicate with your remote SMTP server.
More informations can be found [1] when searching for 

    "git send-email" "sendemail.smtpserver" "msmtp"

Btw. you can remove your password from the smtp config (but keep the
"password" line without the "my-secret" part) and msmtp will then ask for each
mail for your password.

The interface of "git send-email" is quite easy. Just specify the name of the
patch files as argument of "git send-email" and then it will handle the sending +
threading for you.

Kind regards,
	Sven

[1] https://git.wiki.kernel.org/index.php/GitTips#Using_msmtp_to_send_your_patches

--nextPart3821250.YiRq1gnyoo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXmkx+AAoJEF2HCgfBJntG3GwP/0x+LEdeG31aNSbmmCwIym2D
DDZQ93VrZ0dOE08/MNaSbuOZYoV0CuHRbEIQBOeVsGTtDUJ5u5UniVV1a7BEviXE
Cl3+B9tzx8XHyhIl246smYqL7C0lSG0vG4bGouMyNFH0/hebNP/hyD132FyVickP
LdyT9hl78IgxqvWf1+Cos8ZsmJyMs+VTycpR30buugTVDpP7+sZU9rznJ6kdDHob
ZcwuA4Gh5yFQtEhQRO5BTly9m8Z9jMFAxnB8o2M9d0MrH6WRMFZ5LVUFeQOb0+Ei
P4k5CqaQ1fSy2R3yShFN0bOYMaEWAycINx5cKds1E/LpMbSIB/sxitn5TWKckJo3
3x7Z9WaHuJ1FN/9pD323QRQoPySZyFrewHt+pMByOurU89Y4ixUjFajdL59kqUiJ
nNtovQ0sZTrPq9c8xMUAsE/ojV6lczUnU4DPLUZXqMxdYSxHR+hJ0+BtNxpInnlz
7TFyBr8opwRyZxneieOLyA76hALSyUUmHcwX8evLQpDNVWKon5ifIpuZgndVz6cy
cCZVK8S7/X10/p5Wo0Ll5KkBhCq6Y9HJ1jq9ROchDL/U50/i/WCKXQ2YrbnzOsIk
ye7yTaujlEpQRVTLH8YtWmNdgOBWIxnyFXQvwtSmfGGAs3Z7GdpFvqmED8g8dhhu
+FCPepl3PEczhE2x1U4o
=+szS
-----END PGP SIGNATURE-----

--nextPart3821250.YiRq1gnyoo--

