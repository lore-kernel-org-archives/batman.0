Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 27 Jun 2016 08:19:22 +0200
Message-ID: <2649945.JKXkXjyaxK@sven-edge>
In-Reply-To: <20160627023613.GX10666@prodigo>
References: <20160612041426.26339-1-a@unstable.cc>
 <1613308.eWzkVEsf7s@bentobox> <20160627023613.GX10666@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4974825.Q2L8x9B8lV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 3/4] batman-adv: B.A.T.M.A.N. V -
	implement GW selection logic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4974825.Q2L8x9B8lV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 27 June 2016 10:36:13 Antonio Quartulli wrote:
> On Mon, Jun 13, 2016 at 01:26:31PM +0200, Sven Eckelmann wrote:
> > On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> > > +       if (orig_throughput < (gw_throughput + threshold))
> > > +               goto out;
> > 
> > Possible overflow problem in batadv_v_gw_is_eligible. We don't
> > know what the user will add here and what the gw_throughput is.
> > 
> > We already had a similar problem in the BATMAN_IV gw selection
> > code which resulted in weird gw selections. See f63c54bba31d
> > ("batman-adv: Avoid u32 overflow during gateway select").
> 
> Sven, correct me if I am wrong, but in f63c54bba31d we are changing the type of
> the variables aimed to contain the value computed by the "overflowing"
> operation, while in this case we have everything in a if condition: should the
> temporary result be implicitly casted to a larger variable as required ?

No, it isn't casted to a larger type. Yes, C has some wild casting rules but I
would not be aware of an "help the programmer to avoid overflows" casting
rule.

We had no other idea how to fix it in the mentioned commit. But here we can do
it without casting to u64.

Kind regards,
	Sven
--nextPart4974825.Q2L8x9B8lV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXcMVqAAoJEF2HCgfBJntGoBMP/j/UX0/zwZWP2Ukc3g+rZqmU
bkzPO4m9yzjqQufBo3iWt/thu/MIzlOYweZBkoljYqO1xTwBjAE+/Gm6I5LxYLio
dXDU5vG/yPHXFmvlqTT2Z6+/1d4PB5AkwPeF06N5TsdYg8vwjj8sZNd3XT3YUUVB
AKTMwSnyNaOfV90LpqCRjDUsRLLg3eyx9Ne0uDfmv0lSAS7lhpxlyxGq4k9eCIQ5
/C8FFUsJzohRyXk3tZ+F93+ggdCnVeDaZL0A9UG8Bx5F2Yp2R5YQWmKzrDJoGI4G
2MyuEzrgm5bNix2I4Oz8jJbA4L1s+wCoQdJ4TS739fu4AFLoM5ZFckZd7JDluhMA
V8F1CttYGpbRImJKHHlINH+po0uwhfnXf3+GqI+cGG9VAXU7ZNtjZ8XyBs7Fv+kt
yLvam0woHLCyemzXs4bt2oM5dxwlh5Pl+I41vnTKNL7XOUSdjiAs5sXu4r+MeRpW
zwflL7cC+AlocC1h5m1d3HGiYJEG3PbeRfka9TUPVK535QTsZqQjfy3fSKh6afqN
t+yNCPVOAib27lQgk2DihzamxXpKNp/5RQ54kdEweNxLok+SX83oBPcDPoRqf5VQ
bQgH0e9wAjUyoCg2mWaAdwMDtGuEcH5odZQNDrZ4ZU1ukMUmYK7t4bG3dpC6JMoD
dES0P2+mGXfxW/0F2pEi
=DrON
-----END PGP SIGNATURE-----

--nextPart4974825.Q2L8x9B8lV--

