Return-Path: <omer.efrat@tandemg.com>
From: Omer Efrat <omer.efrat@tandemg.com>
Date: Thu, 14 Jun 2018 12:50:13 +0000
Message-ID: <VI1PR02MB36317D29E273A4D88231EE029A7D0@VI1PR02MB3631.eurprd02.prod.outlook.com>
References: <1528971137-432-1-git-send-email-omer.efrat@tandemg.com>
 <1567584.jbsRn7ofiA@bentobox>
 <1528974316.26847.0.camel@sipsolutions.net>,<7318287.kp0SrnPS43@bentobox>
In-Reply-To: <7318287.kp0SrnPS43@bentobox>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for
 NL80211_STA_INFO_* attribute types
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>

Sven Eckelmann wrote:
>@Omer: If you want it as cleanup patch then make it clear in the patch tha=
t
>the warning you've showed here is not actually not something which you wil=
l
>see in in the modified code.

I will send v3 as clean up patch.

Omer Efrat.

________________________________________
From: Sven Eckelmann <sven@narfation.org>
Sent: Thursday, June 14, 2018 2:20:17 PM
To: Johannes Berg
Cc: b.a.t.m.a.n@lists.open-mesh.org; Omer Efrat; netdev@vger.kernel.org; li=
nux-wireless@vger.kernel.org
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/5] batman: use BIT_ULL for NL80211_=
STA_INFO_* attribute types

On Donnerstag, 14. Juni 2018 13:05:16 CEST Johannes Berg wrote:
[...]
> > in commit 739960f128e5 ("cfg80211/nl80211: Add support for
> > NL80211_STA_INFO_RX_DURATION")
>
> Yeah, which actually means this patch isn't needed?
>
> BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT) is fine since
> NL80211_STA_INFO_EXPECTED_THROUGHPUT is actually =3D=3D 27.

Hadn't verified this before but this would make sense. So no fixes here - j=
ust
some "cleanup" patch to make these tests more consistent. Thanks for checki=
ng.

@Omer: If you want it as cleanup patch then make it clear in the patch that
the warning you've showed here is not actually not something which you will
see in in the modified code.

Kind regards,
        Sven
