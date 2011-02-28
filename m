Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 28 Feb 2011 20:29:03 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201102281303.07122.sven@narfation.org>
	<AANLkTinja_Hq4ze-fOFbHRK-iDzzA3Tk0oAsJ+CB=M2S@mail.gmail.com>
In-Reply-To: <AANLkTinja_Hq4ze-fOFbHRK-iDzzA3Tk0oAsJ+CB=M2S@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1627714.gbvihqBmdr";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201102282029.05802.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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

--nextPart1627714.gbvihqBmdr
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Monday 28 February 2011 20:15:05 hlabishi kobo wrote:
> Thanks again for your reply sven, but i think my code might have maybe
> you a different view of wht i want to do, see below.
> The idea is to prioritize recently received OGM's thus giving them
> more weight for the routing decisions. suppose you have sliding window
> of 10, a link A records  [1111100000]=3D 5 and link B records
> [0000001111] =3D 4, currently this will be used towards the calculation
> of local TQ. in the proposed method we want to add the indexes on
> which an OGM was received in that interval. from the example above we
> would have link A 1+2+3+4+5+6=3D 21 and link B 7+8+9+10 =3D 34. this
> actually what i meant by counting and adding indexes.

I know what you want, but it seems (judging from your "implementation") tha=
t=20
you don't know how to write that down. I hope that I gave you enough=20
information to show you why your implementation isn't what you want.

The last part should help you to implement it the right way and to understa=
nd=20
what the values represent and how you should operate on them.

Best regards,
	Sven

--nextPart1627714.gbvihqBmdr
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNa/eAAAoJEF2HCgfBJntG2R0P/iGOZ2W4H7vSZ0dB2c95u0/E
R/38pZow8P/En5pI35icHwTYsHxtu8+stfiox2dOiIwjTNmblAqkZ2RLoFRFgkBT
fA8Os+YEuub2rGPKXWXDlxl4Fmy5LzM9MVNjPwzkUXAEOTwYkzt1iM+rimMcypQo
hDiQ3r6CS2puq7oKyCWfVHjC41o8L8Uq1YfFyK1BiL99QY4DNbuj14huhCOytMyc
H/IF7v8EHdkJ18zcIUWs8y+UQSPuno2snEu8aDG04oNSybMTK3jjXs0VCkbYZT5+
WUFi+fAk0O5EV+UPDUrDTy3KDgNaaLPeu/GxsKW6Wh+z/fqFA5YCkSUT82nhpRBY
IRMiGCkilvdiWpMl0KuGPqrmv4WubDxLNNP4PMmKfO/7uJJPHmdE7Ue43gx+YJcl
MpX7miWsTUOwgpCgY6kL/bOB9JBzJG+E6xycCvXA6MSnmLWO2K1+J8wN4OERRoEz
K5ObtyY5nsSZb06eaENGviJn3Ed0PDO24JGlNKr1BnNX71Q7AuN70CWdZdM9w7Qf
L9PSWyts/xOfS4UiZN2BMW1U0b8kt1h20vvQ7BINWNX+1Gr0DGwhV08X/VYz5cyW
tdRQa+WhM7NaBu08tR6i2uSxPKEQFRB/anPy47qLFDjnenaws3lMGJp8eyZLRw0Y
ku2aZrre5t597C6uOopQ
=yayM
-----END PGP SIGNATURE-----

--nextPart1627714.gbvihqBmdr--
