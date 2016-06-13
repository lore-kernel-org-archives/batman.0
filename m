Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 13 Jun 2016 13:26:31 +0200
Message-ID: <1613308.eWzkVEsf7s@bentobox>
In-Reply-To: <20160612041426.26339-4-a@unstable.cc>
References: <20160612041426.26339-1-a@unstable.cc>
 <20160612041426.26339-4-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1855639.v8BCYeGMG9";
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart1855639.v8BCYeGMG9
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 12 June 2016 12:14:25 Antonio Quartulli wrote:
> +       if (orig_throughput < (gw_throughput + threshold))
> +               goto out;

Possible overflow problem in batadv_v_gw_is_eligible. We don't
know what the user will add here and what the gw_throughput is.

We already had a similar problem in the BATMAN_IV gw selection
code which resulted in weird gw selections. See f63c54bba31d
("batman-adv: Avoid u32 overflow during gateway select").


    if (orig_throughput < gw_throughput)
        goto out;

    if ((orig_throughput - gw_throughput) < threshold)
        goto out;

Kind regards,
	Sven
--nextPart1855639.v8BCYeGMG9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXXphnAAoJEF2HCgfBJntGhnUP/iIwahmrVW45sIX5gLZDzG9V
X2ZIELSZa7IK39DZ5+f21nchgZ5R/3krS19eI07IKpPSF4oyJk37voEpPMjhBL1k
N7BVOD8WK4OZOvTDpQolACeLQM5KL1jE1DiG5dJdsy/DcbWvsiKzWypeikBaJsP+
AFWwxlspESvyXIDqP+tVlhtqEjjG1f3uQg2xRSQ1ipL7NmUTRmgdDD9Q/iKsuAqU
Z9N78rAObbByMX8w+Gn8yNDRNgyyWSl3MzhSbCNF5GaCXR8d3hqx+YKjnKYNQQ6B
anV/t4Kff4cVQygAMV53SpITsaZrlUTUltUCUysGlssK31aXCBh2P86kAdhVeJN8
S5snn2hzwV4fbpQ1kmBvOhB2rRG/FvAXB6Wuzjnoiz7UqOArWBa3wz3HMIHnEj2Y
XRTjW+SHaQIXx7VRiLzuOMv/bKOmvpBmV9fQ0jW9wY/AXO0BOGWMO3Ly+Qkz1Pt9
pWuslPu2jYVy359OFAeH5ZOfT1hsEOAQPLTsnc+WxAPGGj5ecODLxo+C2lEQRxgk
MoZxD5WuSM8kq43Wio4YRQ1NwNG+QH4TCHPQ7/lPyGoJtziRye5ptQNjl00s55Ze
kjWJHWa1TmT/nxZp9WYPZJBaStBEk3kBG3NVjhts1ejOQ8585QhM8s2vFiTcOz+f
B//TMWyO8jfpPON3/to4
=bX/E
-----END PGP SIGNATURE-----

--nextPart1855639.v8BCYeGMG9--

