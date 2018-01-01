Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 02 Jan 2018 01:06:41 +0800
Message-ID: <2752799.a0ICIG4bgH@lafayette>
In-Reply-To: <CAL3ir7KuUTmBkqbDjz4-4V4ee0uEnDWv0Vf_Bq1C_rJTRpkncg@mail.gmail.com>
References: <CAL3ir7LUCHfyxegLn7qbx8cQ_H73V6AnTtBBN2eUPg7Wwn3j+A@mail.gmail.com>
 <2561223.2KfdzXezWu@sven-edge>
 <CAL3ir7KuUTmBkqbDjz4-4V4ee0uEnDWv0Vf_Bq1C_rJTRpkncg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3387289.iBD9McLhXV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] 11ac throughput on mesh links
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

--nextPart3387289.iBD9McLhXV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, January 1, 2018 11:33:11 AM HKT Daniel Ghansah wrote:
> Thanks for your response.I am aware of the bugus 6 mbits display I was
> referring the results of batctl tp
> Should I be using iperf?

You're message wasn't entirely clear to me that is why I added this bit.
You surely can run iperf and compare the results. Let us know what you find.

Please note that the batman-adv throughput meter was developed because iperf 
is not able to saturate the link when running on embedded devices. So, if 
you're using iperf you should run it on modern notebook CPUs connected to your 
test devices. Otherwise the results will disappoint.

Cheers,
Marek

--nextPart3387289.iBD9McLhXV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAlpKaqEACgkQU1VOj+62
HMA+gggApNafKdnkVSPEd/eHx6XljbPKp9xqtyFU/EFmkw1K0BKTtrYfINXAGjiW
ES5riMhM6n+pzD9uAG4urWpO04dCxad9ZbMoIzPozTMtyqbQ1HOZ2yfhWFXllahN
A3rHaXMQoE9nLfl1IZl24tG8b4RjobNFjIDyqcM8WTiCJK4bAGdXOIn2m5s1HD+K
VHH1NB5v7TK2mnHqXACHSLA1cNHXFYGx/Nyenqm9GQrW2Ofa+XUbkH4QNhSwg518
gyKHWnpldVDgDlnAovGlZ0AIw1WWoCvokx5iho1SZZ3lhHGD6QRwHatgVflgheYA
Lw5qcpY8B/NTe5K42w/GfaypXYciSg==
=fjAU
-----END PGP SIGNATURE-----

--nextPart3387289.iBD9McLhXV--

