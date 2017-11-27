Return-Path: <sven.eckelmann@openmesh.com>
From: Sven Eckelmann <sven.eckelmann@openmesh.com>
Date: Mon, 27 Nov 2017 13:36:36 +0100
Message-ID: <215971903.lTGvM6jJST@bentobox>
In-Reply-To: <20171127123341.11365-1-sven.eckelmann@openmesh.com>
References: <20171127123341.11365-1-sven.eckelmann@openmesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2258844.jg0tSgbsW8";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] flow_dissector: Parse batman-adv unicast
 headers
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

--nextPart2258844.jg0tSgbsW8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 27. November 2017 13:33:41 CET Sven Eckelmann wrote:
> The batman-adv unicast packets contain a full layer 2 frame in encapsulated
> form. The flow dissector must therefore be able to parse the batman-adv
> unicast header to reach the layer 2+3 information to allow RPS to schedule
> the flow to different cores.
> 
> Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
> ---
[...]

Arghh, this should have been an RFC. I will mark it this way in patchwork but 
please don't be confused on the mailing list about the subject.

Kind regards,
	Sven

--nextPart2258844.jg0tSgbsW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlocBtQACgkQXYcKB8Em
e0abpA/7Bsey8mTbAqVyk0CdxveZSoQ3LL4IRiuhFBkmloIlm1lCSS+9A/W5qsrY
BxFdLGbfLfLFq+AhXfKuYnKN3+opQhbttocuK5JudQHn7/5jZMBafhXYgeIxLkf4
S8k/Jkrfajtp7dZSV1USw7sytu8jMYQ83+HHmK8c36ncIzwN/+L7WofxYcpbVJLk
zZyZVYklzyLos2bZLuJyKO0qx/ZcfF8B64UfJwK2mOMnAJ+7BXdk2fq9D1EWGYM3
HITFaH7U3H+t3XxaLqw0q7wnyJZ/tFvc9Tjpegwo57NGyNfvn4WHP9CgmK69RZhA
LQQnYBO6STcwutpslYKLwz3O657ww5jlrNqJ1xDYxjwPV9aPsjNDQqbLqpV06Gnc
IcZRajBRePVEnIBsV7JpRFtFp8E7/wU2CFkstgoTi11+vJiJ8ISI/aTbybiPSw9X
Votr1LnUsWJercC68LcR9B0gc2LnbSfbEPa5aY+gWXMbzj7eQtRn/HqO8LT0dsXY
sitHgJ44qQCdG7ONo1UabBCPlktS/gNqN0dQYJY8Ps+yOD5g226DhCxgw4X60DUd
Q5Vrn8Q44VMOZOve2ZnHgJdz4nOx9/6HaSNCOiD2tJy2Qfqb4zZ4EX99OPogPPWH
YuuY8QchR9dGHq0m4p5VDa7P5M8Vhua4UPDWjPeMCfHONUNL1hk=
=03pc
-----END PGP SIGNATURE-----

--nextPart2258844.jg0tSgbsW8--

