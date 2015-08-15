Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 15 Aug 2015 20:40:23 +0800
Message-ID: <1616942.MvSMDqlREL@voltaire>
In-Reply-To: <CAL4ejvTuHjffOhmeSyNJJ0FQHv7nD0_a9NG5LjCnbjOy+qmOcw@mail.gmail.com>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <6739194.7XsaoRhMpp@voltaire>
 <CAL4ejvTuHjffOhmeSyNJJ0FQHv7nD0_a9NG5LjCnbjOy+qmOcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2323185.li9RR6bNDR";
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


--nextPart2323185.li9RR6bNDR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, August 15, 2015 04:21:27 Marc Juul wrote:
> > What spoke against using the batman-adv layer2 fragmentation:
> > 
> > http://www.open-mesh.org/projects/open-mesh/wiki/2012-09-24-GSoC-2012-Mart
> > in-Hundebolls-Final-Report ?
> 
> This was a while back now but if I remember correctly we were getting
> terrible performance when using fragmentation. We were at the time using
> the old Picostation 2 HP routers, which we only later learned perform
> terribly even when they're just acting as dumb bridges, so that could
> definitely have been a significant factor. None of our team were super
> experienced with wifi/mesh when we started out and we are much wiser now
> than we were a year ago when we made this switch, so it's possible that we
> could go back and use fragmentation and have batman-adv work for us now.

I'd expect some impact on performance but nothing as dramatic as what you are 
describing. Would be interesting to get actual numbers.


> However, the privacy issue with a city-wide network using the client MAC
> address for identification still stands as something we do not know how to
> fix for batman-adv. To make matters worse we've had some people
> misinterpret what we're doing and then go out and tell others that we're
> making some privacy-focused network with anti-NSA-surveillance measures,
> which made it even worse to have to explain that anyone who knows your MAC
> can track you as you move about the city.

Though I recognize and share the desire for privacy batman-adv is first and 
foremost a mesh protocol. Not an anonymizer or NSA-defender.  That being said, 
I am not adverse to somebody working on this subject and making batman-adv a 
better place.

I do like to point that even by not using batman-adv one can easily be tracked 
via the MAC address on a national or global scale. Search online for the magic 
words 'presence analytics' and you'll get an impressive list of companies 
(most of them based in the Bay area) offering products & tools able to track 
you all around the country or even internationally (depends on the size of 
your business). I myself have been contacted by quite a number of companies 
asking me to help them to develop such systems. You don't even need to connect 
to these hotspots to be tracked. Passing by is enough.

I am afraid by telling your mesh users that you switched to an IP based mesh 
protocol you lure them into a false sense of 'non-traceability'. It kind of 
feels like a debate we had almost a decade ago when WiFi came to the masses. 
People had the feeling to use WiFi they had to learn what this cumbersome SSL 
thing is. Because WiFi is insecure as the waves leave your home and the 
neighbors can eavesdrop on you .. Countless hours had to be invested into 
educating our mesh users that SSL always is a good thing.

Personally, I rotate my MAC address on a daily basis. That works not only with 
batman-adv but everywhere. Obviously, that won't help you against the 
countless ad networks, Google, Facebook, etc, etc

Cheers,
Marek

--nextPart2323185.li9RR6bNDR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVzzNDAAoJEFNVTo/uthzAIWkH/AhX/b4unE1krU8ZuRpnDxnu
amSmI1YgyhE1s495wM1thI/+g0ks+eG0L/cztrGtyTFwcxCIYXGchHZxrQj2YREV
2acT3AwkzJCkAlwpFXb7ivyKga37ZyVb8k65BnTUr3EtCqqNgf05s6oXW/e6xjrP
4rsOT4wPhQSj/jfnXYdwJDJw2FWQ1w25ORo+fPK1TFgg0h90tR32RfKoaj3aDC/O
NU5XJkuPWbfb+gTR0Hh3aWjeLEnIisqI/OZ5k/ec4kjStWpZngBiEwhsiwJ0D7Rd
Gqj+BXCNHBMyP72ibP0yKokXY0kdcwca13MtjL8klQoVR0pSggUzM9TetVwtXvU=
=3FcE
-----END PGP SIGNATURE-----

--nextPart2323185.li9RR6bNDR--

