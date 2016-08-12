Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Fri, 12 Aug 2016 10:18:21 +0200
Message-ID: <2051990.AEtJ42fJkW@prime>
In-Reply-To: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
References: <1469738596-10972-1-git-send-email-jhaws@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3416227.Qrg8Ixp6sV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] alfred: Externalized synchronization
	interval
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
Cc: Jonathan Haws <jhaws@sdl.usu.edu>

--nextPart3416227.Qrg8Ixp6sV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, July 28, 2016 2:43:16 PM CEST Jonathan Haws wrote:
> Signed-off-by: Jonathan Haws <jhaws@sdl.usu.edu>
> 
> ALFRED_INTERVAL is now externalized via the -p option (synchronization
> period).  If specified as option, user supplied interval is used,
> otherwise the default interval of ALFRED_INTERVAL is used.
[...]
> --- a/server.c
> +++ b/server.c
> @@ -372,7 +372,7 @@ int alfred_server(struct globals *globals)
> 
>  	while (1) {
>  		clock_gettime(CLOCK_MONOTONIC, &now);
> -		now.tv_sec -= ALFRED_INTERVAL;
> +		time_diff(&now, &globals->sync_period, &now);

I believe this at least deserves a comment, or must be made more clear in the 
code.
--nextPart3416227.Qrg8Ixp6sV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXrYZNAAoJEKEr45hCkp6h0RAQAM5Sml2bRuz7y39MmzrZq3hd
R9yK+fNeakfOw7sbEz4X1+DXFvUoaRk36V83egxdRRtswnUIozUijWPZydUXoVpe
aj8xFrMzBfdoGazAeKzbcOOMgJSkxP5LiZ8frTySx2d4ixlgmAghYuWbLY/HmiDC
tKUfd6aot5Xw+UMlp7ld11WZQKeJ1Zmow9/mZ3j++Ra+gGbtQwJVKPuWX+xr41xV
HlHPEkwDB2JAXLRiZbO50QiqYmxtqU39ASqJsoDF8rhau+zIy1e8CoJM5F3yx99x
3kworR4BNtJGLCVd3FNNfkMl+ouYNG75LASYnCYlLvk+frzeWNIxqPLwK6KPsBqS
k9Xk5lsW0Oz/C1CK8uUrjcCMWRYqITDo54sjoTjsu9YnDAUgvT6P7QreFehaZkIn
qWZfbCkAK7Lga0pfKLxGiAV4eiywviJnwcX+KRYRQv7dJgeh1fKnMOIycFLaEkTM
MvATXtQeZLRS+DgNJUEe5uzLMfy3g3Yg+w1YdtWK4e6qPoOu0zAYPZW1aF5pD9/8
ThSlTsdsVK7sCn0c6b3E4ZJ4G4pUHgHAEmmaKrqBEtulBspwfXAsxHks023QfNcC
mr6poJzN9Vhuojzo8n4OVZ9KDnq4DK2mhBduT9Rm7X075nuHJR/DQP9oe7FYpemA
38gjLfFRqNH++g1wRNaN
=K1BU
-----END PGP SIGNATURE-----

--nextPart3416227.Qrg8Ixp6sV--

