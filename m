Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Nov 2013 15:59:42 +0800
Message-ID: <4121725.uIErerH5vU@diderot>
In-Reply-To: <1383595181-2061-2-git-send-email-antonio@meshcoding.com>
References: <1383595181-2061-1-git-send-email-antonio@meshcoding.com>
 <1383595181-2061-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4678207.0HPuzmDds0";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: rename gw_deselect()
	to gw_reselect()
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart4678207.0HPuzmDds0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 04 November 2013 20:59:41 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> The function batadv_gw_deselect() is actually not deselecting
> anything. It is just informing the GW code to perform a
> re-election procedure when possible.
> The current gateway is not being touched at all and therefore
> the name of this function is rather misleading.
> 
> Rename it to batadv_gw_reselect() to batadv_gw_reselect()
> to make its behaviour easier to grasp.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  gateway_client.c | 35 +++++++++++++++++++++++------------
>  gateway_client.h |  2 +-
>  gateway_common.c |  2 +-
>  sysfs.c          | 10 +++++-----
>  4 files changed, 30 insertions(+), 19 deletions(-)

Applied in revision 65afe85.

Thanks,
Marek

--nextPart4678207.0HPuzmDds0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSeKVuAAoJEFNVTo/uthzArAQH/R1q/INi6zfjgrMG6gYSTGyD
CszjkuS9KiObmoIJKCqSSJGgAOrzg+RtEp7yZIHu+ru6J/6khagL+rIWFiDJk93z
KnDMFzqthsxWvqOB/zXuKhvLcjRa5tl9fhpJkBiR+VL1Wbb81OTk05IrvwMdNRrI
rh0nItU+XIl9rblwCmQ8QzjWepFU8grywWSaKy5OlOTC9tfHdFlfsGFPPf11oavD
o9cog5SaNYu8TbBx6J7Hi4Dejj7zOPrTl7PEA1vNo+dpCqo19qG1mVqMTBozZtQS
M5XitQQ/Ui675B9JqQYuFoSlNif3BnJiNWvsVw6Y0rMRtMJFvaao5N8g6H2lf+k=
=Kwdz
-----END PGP SIGNATURE-----

--nextPart4678207.0HPuzmDds0--

