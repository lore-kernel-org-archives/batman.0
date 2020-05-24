Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: Batman-adv packet retranslation
Date: Sun, 24 May 2020 17:55:34 +0200
Message-ID: <3386019.DEOV3mvQ00@rousseau>
In-Reply-To: <CAOVt3fHXmMbTeg1SN9Ngpf7ju6FeUvWzFa9ZsSBLuVhjF503_w@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com> <6286065.m5U1xfpyP1@rousseau> <CAOVt3fHXmMbTeg1SN9Ngpf7ju6FeUvWzFa9ZsSBLuVhjF503_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3192778.bLTUk8KIK0"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart3192778.bLTUk8KIK0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 24 May 2020 17:49:23 CEST Alexey Ermakov wrote:
> - Why direct connections work properly (I mean connections Node1-Node2
> and Node2-Node3 ) even with this throughput?

Batman originator messages are not forwarded when the throughput value is too 
low. Furthermore, the batman algorithm applies a hop penalty on each hop which 
reduces the metric with each hop.
That is why one hop is still works.


> - Why this scheme works then all nodes had seen originators before
> throughput overrided?

I don't quite understand the question, sorry.


> - If I override throughput to 10000, for example, will it work properly?

It should. Why not simply give it a try ?

Kind regards,
Marek Lindner

--nextPart3192778.bLTUk8KIK0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl7KmPYACgkQU1VOj+62
HMB4KQf9EpBOGR/l1jIrLs34um4i3TmgKZAMz+1BQTG3BL0xhsuoRceDxlp/xulR
rCdjr+fy9o1VPD0yUEPhS9RVXmps/cKr2CYbk3+IJqNhXbp6HVaM+i+avf+wqR/S
fm2ntAY3vVG9dhTKHEQcJcx06Bt5TIwHpatUNPB0YBVu94Gke7lJxFdZyFFSs46l
vJ71m5lKhMrsegkPEbtKJGsys1RlzEWfMFN9hMeNumUrHwwS1WKdNrtZ0LtJT9+j
1qyMW1NiOish3KZyXTWKFrPCmjTaMecWptgRwKHTND0lprWfmMtLbivxcUWMfyWT
jb8LOrcoHhCsc3dJzHkH/m6oHcCopg==
=zV+2
-----END PGP SIGNATURE-----

--nextPart3192778.bLTUk8KIK0--


