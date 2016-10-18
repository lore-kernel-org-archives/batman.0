Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 14:29:43 +0200
Message-ID: <3298628.UYncQaiJYi@bentobox>
In-Reply-To: <20160904182331.18118-1-sven@narfation.org>
References: <20160904182331.18118-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3104721.hC10ojanqn";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] batctl: Work around uclibc collision for __unused
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

--nextPart3104721.hC10ojanqn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 4. September 2016 20:23:31 CEST Sven Eckelmann wrote:
> uclibc on 64 bit systems uses struct members called __unused. These
> conflict with the definition of __unused in batctl. Such a conflict results
> in a build error because the struct member will be replaced with the
> __attribute__((unused)).
> 
> This can be avoided by renaming it to the Linux kernel name
> "__maybe_unused".
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Tested-by: Andreas Pape <apape@phoenixcontact.com>
> ---
>  genl.c     |  4 ++--
>  main.h     |  2 +-
>  netlink.c  | 10 +++++-----
>  tp_meter.c |  5 +++--
>  4 files changed, 11 insertions(+), 10 deletions(-)

Applied in 7402351d3bef02d8dac2e9b68a9e3eca472fd33d [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batctl.git/commit/7402351d3bef02d8dac2e9b68a9e3eca472fd33d

--nextPart3104721.hC10ojanqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBhW3AAoJEF2HCgfBJntGL4AP/1KWlDOjCjHBU3hTUOxNx2bH
u8KwHLib4SP4MUPrLHLtea8kxUkTea7nwVWlUOhkVrc5ReYdBYubfOhLSXxvhfyF
9WoFDBqG7/5GVXMCcV8lwan7RF7pOCUR3wnz6m9OGyK9Yn0xOW8jHLlLujHGqMTL
KtNl+EhAyT1ksXNO2efcWUaKgemDCwwgyNb/QGujFwee9YGQPNcZ+10CLFNi+xPs
nMb+lFOIWIdUsDjTM8IG759Xo72faiOI0nfltgblTtI4u1/y+HIWe78CSD4tbQC7
ij30unphs6DEwje1xVNU64K/KhBD6OykYY1wfJICqaxf/582HgFPomXW3LZQbcog
oGExlJtZadWIX6U1+hb+pVoJlwVlZ78ZkQzln4xdLE5Uc2XzTemMhMsB4oRxaXlp
pgsrBSNPpRQsSLl0Skwyl0jIkg3loWhmMpF9y+f1vJQ0ryNswMr2WXVBsW4Iop7W
UpwAAvuDHbNaaA//MKU6mxYqCPXg1fFoV4b2N/6oyui+HrRMTiNfonjiiw41ie1c
XZYAiEGBJinhVqv1UTqb4I20qdhkyNzrFGFwIuIbRL//GmKjarq4Xi9HZng+8KAT
g/IhWYj6xyMr9koJqdWFNb5nqH6sRcHEDSngWpEN0bHFswewAqwgy8g8rfHWtPcN
XijuDe3uJf2EH+UKsKYw
=5gsm
-----END PGP SIGNATURE-----

--nextPart3104721.hC10ojanqn--

