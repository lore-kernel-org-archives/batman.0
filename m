Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: Any suggestions about configuring batman-adv gateways + modems
Date: Mon, 11 Nov 2019 09:37:59 +0800
Message-ID: <2770026.qIgyRiqjke@rousseau>
In-Reply-To: <8b190923-5db5-17b2-da46-538b377d862a@gmail.com>
References: <8b190923-5db5-17b2-da46-538b377d862a@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1986170.X7SbLmUq57";
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
To: b.a.t.m.a.n@lists.open-mesh.org, xbing6@gmail.com

--nextPart1986170.X7SbLmUq57
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

> Yes, batman-adv gateway is what I am using.
> 
> Do I need to write or find a daemon at gateway to sense internet
> connection, once internet connection is lost (and does not recover
> within like 2-5 minutes) then advertise batman-adv mesh network by
> "batctl gw_mode client" to turn this node to be a client?

you can have a mechanism to detect if the uplink connectivity is down and then 
have the batman-adv gateway switch to client. When the uplink is back, you can 
switch to gateway mode again.

Depending on how your uplink works, you may not need to write a separate 
daemon to check (though you can if you want). Most uplink solutions provide 
some kind of scriptable event for up/down changes. Depends very much on your 
setup and what you'd like to react to. 

Cheers,
Marek

--nextPart1986170.X7SbLmUq57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl3Iu3cACgkQU1VOj+62
HMAIewf9GsRKaRoRT8xehmsxdKdq6xW5WXgWkVXnuF3/8p0t+3fN4cdaLo7B95m7
kucfarAoAhZDt5vfvyw/flyCcNLiO4DRmXpXEyh/5SbGqfmity+Qm5B3ix0wyIFg
YNznlB+6WCwvAikc+U0HbFbGH/LMsnUBQuRGyTkU7xuxGXbQvD/l1dpe2NF4KcZ9
hZREfUitBk5Ofr1syzEhJULtGNyw6cUXewWLWy9mPY++17JIbqxE0XfjN2WxDlWI
eRW3z98Ad82/0CZDOU56mcU/qYsmepXmpIdS077ujXBSm2GqHtlJiqxm6teDEsB5
zdT5j1HZoz15D0fsqRVTidWC+bPARw==
=SdU9
-----END PGP SIGNATURE-----

--nextPart1986170.X7SbLmUq57--



