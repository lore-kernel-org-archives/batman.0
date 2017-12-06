Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 06 Dec 2017 11:43:02 +0100
Message-ID: <15758616.MhDsWncctP@bentobox>
In-Reply-To: <20171119140517.24329-1-sven@narfation.org>
References: <20171119140517.24329-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart63026022.hpu5jhkS8c";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 0/9] batman-adv: License cleanup
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

--nextPart63026022.hpu5jhkS8c
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 19. November 2017 15:05:08 CET Sven Eckelmann wrote:
> Hi,
> 
> the kernel community is currently trying to make the licensing status more
> clear in each file. This is mostly done by adding SPDX license identifiers
> and defining a set of rules how these license related information has to
> be stored.
> 
> I've used this opportunity to go through all files (for example with FSFE's
> `reuse lint`) and to annotate the files according to the "Linux licensing
> rules" and FSFE's REUSE practices.
> 
> There are two things which could be seen as controversial:
> 
> * change of batman_adv.h to the Linux preferred license
>   (I am waiting for Acks)
> * explicitly mark remaining files as licensed under the GPL-2.0

Applied in f795e77ba40d..8de104e049ea

Kind regards,
	Sven
--nextPart63026022.hpu5jhkS8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlonybYACgkQXYcKB8Em
e0a/uBAAlvR6Gtja5xJA4sssJxm5liZ3pATYi0MdwLqhVStO2xyC36zz8wwk85y2
F6Q9vtbIynBt2Q1CKIRzph5tdDt/0d0ohWIyEb/WCSg24u2+I5u25xTzF/JCXoMW
dZmXEwFtnDYIBzrMT3rQ+M0x4QFpUtN3DahDvXGCVfN9jFpz4MUgv7FxomFCjpAV
2Vi1IHIkME9ssohhvtLvaBaLGMbfmymEOFYBmlwQUgaD5d3ni8N7bQDL07OOIBB/
Z4CIl7cIrOG6FvifnC9oYfhzNWNIVeuBQYwWOg48AmH1lyHysLYryCodufH7oZwV
HsdNqqkdgL1O0ZmarsdreS/mXjVoOX4PbJSOpkAevqbiRanthuse3tCR4mZ/HQjM
Eub+76JBoRxnv0WkJQisQuZ2py18xva0NEh5qJyjH0R7gzxemEWsYDFnivD12AE7
qLSkDVM9Gem/wqlEvBMKYaLrxuLH+YkqIhq0BHsXWQIgtllHZo9X+0KtdfbqsnI0
GmxgF3VaZeE8OcWoRLpetTdgw9F82vI87qN2rJCwYp9DyyUrolcMbRXDL/AZyAwY
/6FZq9y9d3qjVhq/jta3nyzreXQto5ZOucdDQc11pB1vAP/xZX5cKrlNZCm4CPLY
cLberGU9bcDeUWhmac1M8hpmYxDChlLyeCeAIJrSVl8JvPc7BrE=
=JDNY
-----END PGP SIGNATURE-----

--nextPart63026022.hpu5jhkS8c--

