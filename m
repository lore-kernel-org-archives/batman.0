Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v4] alfred: introduce 'server status' IPC call
Date: Tue, 22 Feb 2022 00:19:43 +0100
Message-ID: <2116595.VMJfFIaldL@rousseau>
In-Reply-To: <49865018.WmOq9pY62i@ripper>
References: <20220220183614.54865-1-mareklindner@neomailbox.ch>
 <49865018.WmOq9pY62i@ripper>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2369180.30GYhE2k2L";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Sven Eckelmann <sven@narfation.org>

 
--nextPart2369180.30GYhE2k2L
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Marek Lindner <mareklindner@neomailbox.ch>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v4] alfred: introduce 'server status' IPC call
Date: Tue, 22 Feb 2022 00:19:43 +0100
Message-ID: <2116595.VMJfFIaldL@rousseau>
In-Reply-To: <49865018.WmOq9pY62i@ripper>
References: <20220220183614.54865-1-mareklindner@neomailbox.ch> <49865018.WmOq9pY62i@ripper>

On Monday, 21 February 2022 10:14:18 CET Sven Eckelmann wrote:
> On Sunday, 20 February 2022 19:36:14 CET Marek Lindner wrote:
> > diff --git a/alfred.h b/alfred.h
> > index 9ab92a2..598d38b 100644
> > --- a/alfred.h
> > +++ b/alfred.h
> > @@ -33,6 +33,9 @@
> > #define FIXED_TLV_LEN(__tlv_type) \
> > htons(sizeof(__tlv_type) - sizeof(__tlv_type.header))
> > 
> > +#define FIXED_TLV_LEN_PTR(__tlv_type) \
> > +       htons(sizeof(*__tlv_type) - sizeof(__tlv_type->header))
> > +
> 
> This doesn't apply on master. And also doesn't make a lot of sense, because
> you can now just use FIXED_TLV_LEN(*whatever). So I have dropped this part
> and applied the rest.

Your proposal did no compile and the master branch now also does not compile
on ipq40xx:

unix_sock.c: In function 'unix_sock_server_status':
alfred.h:34:46: error: 'status_op_mode' is a pointer; did you mean to use '->'?
  htons(sizeof(__tlv_type) - sizeof(__tlv_type.header))


> Btw. good that you've spotted some prints to stderr which should actually be
> to stdout. You only missed it for "mode: unknown". 

The alfred server running not in primary and not in secondary mode was stderr
worthy for me. But I also don't feel strongly about this.

Cheers,
Marek

--nextPart2369180.30GYhE2k2L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAmIUHg8ACgkQU1VOj+62
HMBYMwf/WhorIkwpBquazXE7DxbWIvtaQpowAcPRHSLVafLJvRL7MGR1ovsX40CY
VmQl4/l8hq7RDG51S8fwhsCmpIfm2wxZ3OaMZXrs2VPS/I3ux5Jsa8D1l4rY96am
5nbDQXAjJaVTK12goXrwPZit3TdEIsj9z8R4cACRfhpE0j62Pj3gbyrXDlPYNBXt
dlE4YRTJCxli+IhYyk9PeOt4sP/ZHkyayPRauBfFteD/1ZUTgxeIXXmXRluMcdDh
z6HjLa0zsrDl8h8Q6aikVQ688QOVguXNrJ6Cq30APmlscvlzK3xUatUnuUeSABnF
SgUlfdCUiRdulm4QM9UcqDrB2gcLHA==
=gGQX
-----END PGP SIGNATURE-----

--nextPart2369180.30GYhE2k2L--



