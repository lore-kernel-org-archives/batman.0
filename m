Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 30 Oct 2018 15:27:06 +0100
Message-ID: <1765107.oBNBABI5Dg@sven-edge>
In-Reply-To: <167f3ed693cf1bd489d4fe652bfca655d2597a57.camel@sdl.usu.edu>
References: <02ef01d466a6$f0c629f0$d2527dd0$@sina.com>
 <001901d47010$d20e57d0$762b0770$@sina.com>
 <167f3ed693cf1bd489d4fe652bfca655d2597a57.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4847680.Qmb9oaJMDL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] alfred and batadv-vis issue
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jonathan Haws <jhaws@sdl.usu.edu>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "guohuizou2000@sina.com" <guohuizou2000@sina.com>

--nextPart4847680.Qmb9oaJMDL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 30. Oktober 2018 15:20:56 CET Jonathan Haws wrote:
[...]
> The latest patch resolves that oversight. From the results you sent it
> appears that the latest patch is working for you. If so, can you update
> the patch with a Tested By: name <email> line in patchwork (
> https://patchwork.open-mesh.org/patch/17597/)?

No, the line must be "Tested-by: $Full $Name <$email@$address.$something>" 
something else is not detected by Patchwork. The last "Tested By: $Full $Name 
<$email@$address.$something>" from you for example wasn't detected and I had 
to manually add it to the commit message.

Kind regards,
	Sven


--nextPart4847680.Qmb9oaJMDL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvYajoACgkQXYcKB8Em
e0ah7RAArWgKw7nhditx+11ibvSg/DjFNBVw8w5lqU2OkJpETP0mYeipAmKqR4Vk
U6r+61IBe2XjMWaUawQbDJPJyZVQyj2jWI76eR2r1sXp5sRmknMfpJBKNxL6ro7B
QiPWYOe30/tCC3kRhAl0KoggjQ5pah3AX7RiL/biASv0B183pN3D0nznIqmw9J8V
1jv6ZnSqYrukoQrfJdK7eTdp4RBnlFWc3TXL52DH033iJpI87txwerzAvWmPsIC6
3RyEsVKISb4tklaGCDZ3Ha983zyNvFrtVZrFtxci0EzR8Au5sggzG9W5LM2jyWNO
VbDyAWZF2ohkf6YEUKYGJWvoJNYeGYp9L6t+N1jSuIk55ztwAhg8Ax03nx5/gJJ4
ZCxXle61VQRIidUgL96A/iK8IxV9g0st2kGAf0zS5+WTZSIaXLPY8EBYN/6+7ZaO
3g9qK1KgXFLxzKDSFP77khHji5jyEwMku+H7PCXAF3c4Tocauy4rPBJJVbXf/sa4
M0HUfdQaRHGPQa1ZdfKlVXoWAepx+gYNm+4QigJwKKJFlFpvs8OlzMMGQGv5bfe1
0TkTjwYYABsy8YJwY11vNofKXhaFVx33SM4tIUpNlHgxJ05ssFi9xVgSW28i+uFB
5CIllaGAivFXqOYG5HPT6v9a9q4vAC1tzPlRY9T+MHthvLUMb1U=
=lG13
-----END PGP SIGNATURE-----

--nextPart4847680.Qmb9oaJMDL--



