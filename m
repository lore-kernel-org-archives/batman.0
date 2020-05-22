Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: Batman-adv packet retranslation
Date: Fri, 22 May 2020 13:41:41 +0200
Message-ID: <14217483.HvAlGTDFyM@rousseau>
In-Reply-To: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6604068.RrEA1Lxpi4"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart6604068.RrEA1Lxpi4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Alexey,

> There is a problem with retranslating packets in B.A.T.M.A.N. V mode.
> I have 3 stations, st1, st2 and st3 with one active network interface.
> This interface is configured so that st1 and st3 can see only st2.
> I expect that if I join these stations in a bat0 network, then station
> 2 will act as a repeater and all three stations will be visible in the
> bat0 network.
> This works fine if I selecting B.A.T.M.A.N. IV algorithm, but doesn't
> work in B.A.T.M.A.N.V.

can you please provide more information as to what does not work exactly ?
The neighbors don't find each other ? Payload traffic does not flow ? ...

Kind regards,
Marek Lindner

--nextPart6604068.RrEA1Lxpi4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl7HunUACgkQU1VOj+62
HMDl9Qf8CK9jniGVk16p7tqmfo2zIHNemGvNa1PKE0zsNJAytxwnymN6RYLjCtOB
vW98GnaF/IfVN0uZ0FRxO7D5f4Y6XhdTsRug320Xf1SHqvU1uXonC0inXLXIZd/V
0SMF94PFeaDspjolrUBMP0Wz50DfWesO49r2a+2i+SKsaFulqtfidEFkspfYki3o
zJZC+W+Gw9o6GmERAPuchlfsnw5bVT7cIBHwaXtHG7boK7c2VkxqjNRtXxEkZZjx
+Iej8nz7kZbrpbNx4JHr051L/6YLhGJhXngrXCaY4ZYGhciQUnwQuCMqGjv82q7Y
bzMoHzdCQbsj6w0+Jw0avNed2zypCg==
=IIgr
-----END PGP SIGNATURE-----

--nextPart6604068.RrEA1Lxpi4--


