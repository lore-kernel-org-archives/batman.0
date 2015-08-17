Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 17 Aug 2015 16:57:10 +0800
Message-ID: <1735926.sqdKcyb43X@voltaire>
In-Reply-To: <CAL4ejvQDGtSx_NH3SmvmFAOwFvfWbP0ArQ-+b74PCm4dNwimFA@mail.gmail.com>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <1616942.MvSMDqlREL@voltaire>
 <CAL4ejvQDGtSx_NH3SmvmFAOwFvfWbP0ArQ-+b74PCm4dNwimFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10140674.SR2AbxaBHU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Why we switched to Babel
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marc Juul <juul@labitat.dk>
Cc: Jernej Kos <jernej@kos.mx>, b.a.t.m.a.n@lists.open-mesh.org, Jenny Ryan <tunabananas@gmail.com>


--nextPart10140674.SR2AbxaBHU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 15, 2015 07:05:17 Marc Juul wrote:
> > I am afraid by telling your mesh users that you switched to an IP based
> > mesh protocol you lure them into a false sense of 'non-traceability'. It
> > kind of feels like a debate we had almost a decade ago when WiFi came to
> > the masses. People had the feeling to use WiFi they had to learn what this
> > cumbersome SSL thing is. Because WiFi is insecure as the waves leave your
> > home and the neighbors can eavesdrop on you .. Countless hours had to be
> > invested into educating our mesh users that SSL always is a good thing.
> > 
> > Personally, I rotate my MAC address on a daily basis. That works not only
> > with
> > batman-adv but everywhere. Obviously, that won't help you against the
> > countless ad networks, Google, Facebook, etc, etc
> 
> I hear you.
> 
> The biggest danger I feel is that associating to one of our access points
> once with your phone would then allow anyone, even a technically
> semi-literate stalker, to track you and find out where you live and work
> using something we built. My fear would be that someone could use this data
> to put up a public web app where any idiot can put in a MAC address and
> instantly get a nice map of movement activity.

I think we are at a point in our discussion where we just repeat what was 
already said. batman-adv certainly can be improved to provide better anonymity 
by default. Even with such a mechanism in place people can be tracked in your 
network (with IP mesh routing or without). Tracking without connecting to your 
network is even easier than that.  

Therefore, I favor education over a technology arms race. The latter you won't 
be able to win as you eventually will have to battle people's desire for the 
'least effort route'. 


> Hopefully these tracking services you mention are not quite so easy to
> access and use for something like this by an unlicensed individual (but
> maybe they are?) though even if others are making these types of services
> available, I'd rather not make it easy for them to use our network for their
> nefarious purposes.

These systems are built for absolutely non-technical users. For those who 
prefer videos over boring texts:
https://www.youtube.com/watch?v=hCGiGaRp7-U

I recommend to pay close attention to the section they call 'loyal customers' 
(around 1:30min into the video). Note that this was just the first search 
result that came up. There are many more.

Cheers,
Marek

--nextPart10140674.SR2AbxaBHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV0aHvAAoJEFNVTo/uthzAl1wIAK0UimbgOMBVt98j7gwLVQ0L
8lgSuUul3XvYDbMyLUowkpyX699O9UMCFp7paLC5BKYaCTFB1K/8tXzlKdOGp2FM
gfUpygVb+lM6jTkanel2DD90YB6GGW6/ap9jUgIL/Vx36xOrvZMKy/dqyxVefsJC
CJb8cwsxfcTYNDhvlXA1EKuso8WuFIZdyI1F281yse/b+nK3/6hWHyZ5q8nuBiSR
z58pv1y33o7KDwRmp+/YofDx7jCOVlsZET4kSoFzJDUEZx/ato0P1fPVbDke8EDw
12OvqLfPkj8KpI6wi8lhdwzCmT5JwImoU9lrNaCxK59pmpI6awMylHB3/jMllIY=
=O7Si
-----END PGP SIGNATURE-----

--nextPart10140674.SR2AbxaBHU--

