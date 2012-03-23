Return-Path: <ordex@autistici.org>
Date: Fri, 23 Mar 2012 08:50:10 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120323075009.GB16353@ritirata.org>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<20120323063206.GA5662@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Content-Disposition: inline
In-Reply-To: <20120323063206.GA5662@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [RFC] ELP
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


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, Mar 23, 2012 at 07:32:06AM +0100, Andrew Lunn wrote:
> The problem with broadcasting the ELP packets is that they are always
> sent with the most robust coding rate. So ELP gives you an idea how
> good the 1Mbps broadcast channel is, not how good the unicast channel
> the automatic rate selection algorithm is using is. I think we
> discussed mixing in some unicast packets in the forward direction. The
> ELP packets containing the reports would stay the same, and so
> function as node detection. But a node could also send out unicast ELP
> packets to its known neighbours and they would be included into the
> LQ.

I agree with you Andrew, I didn't think about a concept yet, but adding a
unicast reply or something like that would help a lot imho. (Actually is th=
is
what Babel do?)

>=20
> There are obvious drawbacks. More overhead, especially in dense
> networks. It is also not clear if the measurements would be
> better.

What about having a dynamic advertisement period? Again, I don't have a con=
cept
about that, but, if I remember correctly, there is another protocol called
Trickle[1] which does something similar. We could take some inspiration.


Cheers,

[1]: http://csl.stanford.edu/~pal/pubs/trickle-nsdi04.pdf

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPbCsxAAoJEFMQTLzJFOZFxmsIAMFmaFuB48qe7qDE/A0kY94S
jUgEcVj8OaffG7fNilnvrgHM3QeZzMCrW2rQ2ldSNRx6s3JyKitgxoc9bNWudaiL
U6B0IJMTxd7dMuTTeob+d5fQM3io2uF+IZPU4QHWW/u+6Gr0RT/kOmPIMn7Kd7Ud
6ybnGMHE3xs08aD0G+t3TThX7jDoaoafvmcyxGMDvCLQde3FsREqVIotv0Uzd0k1
6oHwQZnG6QP93ZFs2/QJ9bPyFxDo/mXT2YUq7gxi2DcutE0zD8Fh8qpk0d5wSol6
d+DtXhMTqTFPowNLqTVoYNl8XfqerAihTRrkEKeBxdi28sCl9g/NnD+7Fles+1w=
=0/cB
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
