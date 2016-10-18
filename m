Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:36:54 +0200
Message-ID: <1922617.Fm39AeqfD1@bentobox>
In-Reply-To: <20161009065738.8279-3-sven@narfation.org>
References: <20161009065738.8279-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3091734.dEliAiAQo1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [next, v2,
	03/11] batman-adv: make netlink attributes const
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

--nextPart3091734.dEliAiAQo1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 9. Oktober 2016 08:57:30 CEST Sven Eckelmann wrote:
> From: stephen hemminger <stephen@networkplumber.org>
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> [sven@narfation.org: Add compat-patch script]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - remove second replacement line which basically does nothing
>    (thanks Linus)
> ---
>  compat-patches/replacements.sh | 5 +++++
>  net/batman-adv/netlink.c       | 4 ++--
>  2 files changed, 7 insertions(+), 2 deletions(-)

Applied in 801d51e947da78bc542b30ee8e6971f941f8f66b [1]. It was slightly
modified to use __genl_const from https://patchwork.open-mesh.org/patch/16730/

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/801d51e947da78bc542b30ee8e6971f941f8f66b
--nextPart3091734.dEliAiAQo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBglWAAoJEF2HCgfBJntGBsYQAKPuNvt2asVGf7aysFczykVL
7oO2yz7oxK3KRAeySiaaBjDQvJ4q3FJ2N98N+F3HXzIOrAQ/C1Ur6h1om4uCgerf
ef0R0y50SI7UCGqInVT+gcBviuCW5WOLck6FIopAiec930G7olxUuUAIeZD8RUmy
CWymzQaCqWhK/LN7zj400vS9EzmEqSjB00qwock39aIC3EeoYPfSMS6OYrxvk20h
BDsX0yr1V423ghkRbLumfGFFgh4qMYgteWq/65ofpavaITYNT4VCUguxnQPMFzek
lD889goWWm5n27BbWyp02pIzxqVIDzyAUm74FJ7LMPtzHQxFqJKRqYAaB72qlis0
lL9xPryOwb3HNuITmNhZwW3yTC2R+b8CfoRgLNf/fGwrjg+yRHjT41UMNNS9r7Kq
uvw+oidQak7vzCvKk9Xx0UcBsP3GVGAdUAGc82NWjK6d9JRk2WX0dg8bHfFApbHf
Segu2rPZFoIhA6eoj+aTWNRtiN37m9Ycj0AnObd0z5RdSqP37vwmK+L0prKUAakB
UZVuBXnyaZ1cImuD2hQDB24d2lZ0I2L9hwXmUf8OyXxZwhs9rSzi8/GSE1yGVRBq
kOFb7Pk2dX71oPheOmbUZkbFtShdLe2cCEJ0Ria/oefhp//UR6m4dCqfy9KLLISG
4aw/0I+XEcQZPhqC1J9A
=lkaZ
-----END PGP SIGNATURE-----

--nextPart3091734.dEliAiAQo1--

