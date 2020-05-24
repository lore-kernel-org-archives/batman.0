Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Batman-adv packet retranslation
Date: Sun, 24 May 2020 18:28:22 +0200
Message-ID: <2164745.TYCVdmGlQZ@sven-edge>
In-Reply-To: <CAOVt3fE8-U73oJV2XjnxFzWc35LAMeXeaNsTUUgPaLqvchv-Cw@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com> <4485194.d5W8GeZ6RB@sven-edge> <CAOVt3fE8-U73oJV2XjnxFzWc35LAMeXeaNsTUUgPaLqvchv-Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3568401.2ZN2OWTBjJ"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Alexey Ermakov <axel101@gmail.com>

 
--nextPart3568401.2ZN2OWTBjJ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, 24 May 2020 16:43:55 CEST Alexey Ermakov wrote:
> Sorry, I didn't provided full information about experiment conditions.
[...]
> 6) batctl hardif eth0 to 100                NOTE: If sklip this step,
> all works fine!
> 
> After this I started host bridge interface br0. NOTE: if bridge had
> started before batman configured all works fine

As Marek pointed  out, you told batman-adv that the  eth0 interfaces have for 
some reason a link speed of 0.1 [Mbit/s] (or 1 [100Kbit/s] - what the actual 
unit is for B.A.T.M.A.N. V). And unfortunately, 88% (for the hop penalty) of 1 
[100 Kbit/s] is in integer arithmetic 0 [100 Kbit/s]. And 0 whatever/s is just 
discarded by B.A.T.M.A.N. V [1] and not considered for routing traffic - hey, 
this path ends up as being 0 and therefore useless.

The reason why you want to set the link to 1 [100 Kbit/s] has to be figured 
out by yourself. But for a (during forwarding) strictly monotonic decreasing, 
integer value, it is a bad starting point to set it to 1 [whatever-unit] for a 
multi-hop setup.

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/blob/e946e0beec5764ed5182943bf764f8793f1364bf:/net/batman-adv/bat_v_ogm.c#l880
--nextPart3568401.2ZN2OWTBjJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7KoKYACgkQXYcKB8Em
e0anYhAAjxWWQ6KsBREUHNb3dho2TfVRiSaOMgnaFGDxYxZeMV7HetFFsFPYwjas
JLNZaZqKBOkdru+9Z0iG1tYjaypVhpbp6mefUY6qCwvgkBzaMVmNfv33Y4JYbas8
WNfl4gy/7TowaEbDQTRKz3VkR6CoXIB5Vq2eZ9I/siDn4VBmsApgFgRwbnCe3ecD
5W10JJe9HePLROT5aDYc/u7+JeuvYDD6CA5d8jtH/14+uWNOtrPUcTPgUvwA6qR3
vFvDFaaHMIKkBo0njfdS2qTkovKOdKzHjJjw/tV4Pw1hjnbtP93CbgnKrbkCc836
1JA7dkWjdg16byi2iCV7zYHHhPjb/X/QysyN0u6RY76NjXFFi8ZIi7b9Uyo3pM2a
CNlDys826q0Et167SvxsOCCtrTbpVOWwVLLl7UPeAXYLCyAWsLqatnTR3L+pQ2lW
BPOtO9GEI1KD9p9VNGWAWG+MEYQsU3QojdcSAytqAnfvSwycEC/YwNEF8+GJNlg+
gaOqvcyJgYTNc5hecLfyFmAUuNGvVf15ZNCmJS0ZXwEVlVGSbTNLBHon0ml5FE0Q
/cnJOaUQSWpODdkN4nyISCbgwgUMQ3kfV5SO3srmwIbCxXgNpHwr8iG/Mvkb/JJb
yJz9+IX7Sh5Wu9pbqu2zX1c7hNAovAmQle1XXGjenpdrJEzinTc=
=Rp4y
-----END PGP SIGNATURE-----

--nextPart3568401.2ZN2OWTBjJ--


