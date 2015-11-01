Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 01 Nov 2015 16:32:09 +0100
Message-ID: <2794351.UgJrBE9pQk@sven-edge>
In-Reply-To: <20151101151302.GA32213@pengutronix.de>
References: <1787438.NkeQ2a2MeO@sven-edge>
 <1446290970-24053-1-git-send-email-sven@narfation.org>
 <20151101151302.GA32213@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1863597.fn73MdoYj9";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc of main
	functions
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1863597.fn73MdoYj9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 01 November 2015 16:13:02 Markus Pargmann wrote:
> > diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
> > index 06bab51..3404195 100644
> > --- a/net/batman-adv/bitarray.c
> > +++ b/net/batman-adv/bitarray.c
> > @@ -29,10 +29,16 @@ static void batadv_bitmap_shift_left(unsigned long
> > *seq_bits, s32 n)> 
> >  	bitmap_shift_left(seq_bits, seq_bits, n, BATADV_TQ_LOCAL_WINDOW_SIZE);
> >  
> >  }
> > 
> > -/* receive and process one packet within the sequence number window.
> > +/**
> > + * batadv_bit_get_packet - receive and process one packet within the
> > sequence + *  number window
> 
> Are you sure this works? IIRC some time ago multi line function
> descriptions were not supported.

Yes, it works since 2009 [1,2,3].

Here is the kerneldoc (text) output for the function you've quoted:

    Name:
    
    batadv_bit_get_packet - receive and process one packet within the sequence number window
    
    Synopsis:
    [...]


Kind regards,
	Sven

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=6423133bdee0e07d1c2f8411cb3fe676c207ba33
[2] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=4c98ecaf350737cd424eb94140e9e9f1a3408956
[3] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=47e0c88b37a5c3d6732f4ec896dfa8aa55868b4f

--nextPart1863597.fn73MdoYj9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWNjB5AAoJEF2HCgfBJntGZdoP/i41SN/bbkGuDawbK1QG/WK7
wWjZaYk4l698GddZEZtaqobeYsYDvk+J5FZbt674fLqLYltJ1b5tqJuA9/KbsQMk
GyV8TRIZ5rgOBcoVh5VkiVan8kMMcXVlEQSfbvgT8FO7pvxm1DD9ERHxNI2aDsZy
fpdjU9O6dNYXvye8aeUkKxzQRx4lZ/HQbvooA7ZFSPS39pybrlvBlfm20UVJbEOy
My4obZqQNm/gmPusg2/3045RM3yddge+B5SqmHoJAoq0SvjSNhTQmqDc0VZRfPUv
Leu/9Gw8U/JzpLuS3zbN2R4D48WRRfs8WPz1gX9RO3h2TscrB3KLuihpspjn1n9+
IwJJBd0GrsDEYCAUdg8xCItVjc0No0Tt8Uy+JtQ5R1F9FGWm/JhFnHw7a5mB7Yma
kS7bjSQubHkr4VZaCAWZ7onRJpFSHKNGIfXAgjAeynO8+pU7bsWt9322t0Yb59TN
Qde6XHTX2bmVCJgP1UahX7MYeemyq76PqZ/FZ1y9It6nueHUbpaz7n1yYs/ul+do
bi8Q0aQdcB72LAGgM2k25sni8JE7M36ZpwD7UHZaKo0xea5bAXFI1ttrAvm8XPJS
4OVVa/vQaJ2PMpUgWLJzf67F0soDsjbVADwKnTD0DC4GsgYIU4jBZLagboPd3rjV
JykPTNf0Gs43pwESHgDC
=RLY6
-----END PGP SIGNATURE-----

--nextPart1863597.fn73MdoYj9--

