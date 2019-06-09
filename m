Return-Path: <treffer@measite.de>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
References: <20190609101922.2366-1-treffer@measite.de>
 <3378734.H6Auf9Yjlj@sven-edge> <3224708.U1DPrJmi8S@rousseau>
From: =?UTF-8?Q?Ren=c3=a9_Treffer?= <treffer@measite.de>
Message-ID: <accc8852-ded3-188b-b72e-313d1b462d18@measite.de>
Date: Sun, 9 Jun 2019 14:45:06 +0200
MIME-Version: 1.0
In-Reply-To: <3224708.U1DPrJmi8S@rousseau>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>, b.a.t.m.a.n@lists.open-mesh.org

On 09.06.19 13:40, Marek Lindner wrote:

> On Sunday, 9 June 2019 18:37:54 HKT Sven Eckelmann wrote:
>> No, we are not interested in rx rate for tx throughput estimations.
> Before ruling rx out, can you explain your thinking behind this magic for=
mula=20
> (if smaller compute sum and divide by 6):

Sorry, I should have provided way more context here.... The formula is
min(tx/3,avg(rx,tx)/3), which is tx/3 for rx>tx

My thinking was
1. it should be lower than an expected throughput measurement (play it safe)
2. it should still be roughly in line with expected throughput as
implemented elsewhere

I am testing this on devices with ath9k (2.4GHz) and ath10k (5GHz), so I
was looking at the estimates I get from ath9k. Here is a dump from my
home network on 2.4GHz/ath9k and what rx/3 would give us:

> signal=A0 tx=A0=A0=A0=A0 rx=A0=A0=A0=A0 expect=A0 tx/3=A0=A0=A0 min(tx/3,=
(rx+tx)/2/3)
> -77=A0=A0=A0=A0 13.0=A0=A0 43.3=A0=A0 6.682=A0=A0 4.333
> -57=A0=A0=A0=A0 130.0=A0 117.0=A0 44.677=A0 43.333=A0 41.166
> -53=A0=A0=A0=A0 117.0=A0 130.0=A0 42.388=A0 39.0
> -82=A0=A0=A0=A0 43.3=A0=A0 6.5=A0=A0=A0 13.366=A0 14.433=A0 8.3=A0=A0=A0=
=A0=A0 (!!!)
> -63=A0=A0=A0=A0 52.0=A0=A0 86.7=A0=A0 26.733=A0 17.333
> -58=A0=A0=A0=A0 130.0=A0 173.3=A0 29.21=A0=A0 43.333=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 !!!
> -82=A0=A0=A0=A0 6.5=A0=A0=A0 43.3=A0=A0 2.197=A0=A0 2.166
> -48=A0=A0=A0=A0 104.0=A0 65.0=A0=A0 40.191=A0 34.666=A0 28.166
> -69=A0=A0=A0=A0 57.8=A0=A0 13.0=A0=A0 20.49=A0=A0 19.266=A0 11.8
> -58=A0=A0=A0=A0 86.7=A0=A0 52.0=A0=A0 33.507=A0 28.9=A0=A0=A0 23.116
> -61=A0=A0=A0=A0 57.8=A0=A0 72.2=A0=A0 29.21=A0=A0 19.266
> -42=A0=A0=A0=A0 65.0=A0=A0 72.2=A0=A0 31.218=A0 21.666
> -58=A0=A0=A0=A0 52.0=A0=A0 1.0=A0=A0=A0 37.994=A0 17.333=A0 8.833
> -56=A0=A0=A0=A0 115.6=A0 144.4=A0 29.21=A0=A0 38.533=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 !!!
> -65=A0=A0=A0=A0 39.0=A0=A0 72.2=A0=A0 22.338=A0 13.0
> -55=A0=A0=A0=A0 58.5=A0=A0 72.2=A0=A0 29.21=A0=A0 19.5
> -65=A0=A0=A0=A0 65.0=A0=A0 72.2=A0=A0 31.218=A0 21.666
> -59=A0=A0=A0=A0 86.7=A0=A0 117.0=A0 35.705=A0 28.9
> -78=A0=A0=A0=A0 7.2=A0=A0=A0 1.0=A0=A0=A0 4.394=A0=A0 2.4=A0=A0=A0=A0 1.3=
66
> -22=A0=A0=A0=A0 65.0=A0=A0 72.2=A0=A0 31.218=A0 21.666
> -49=A0=A0=A0=A0 72.2=A0=A0 72.2=A0=A0 33.507=A0 24.066
> -68=A0=A0=A0=A0 13.0=A0=A0 21.7=A0=A0 8.879=A0=A0 4.333
> -56=A0=A0=A0=A0 52.0=A0=A0 52.0=A0=A0 24.536=A0 17.333
> -66=A0=A0=A0=A0 43.3=A0=A0 52.0=A0=A0 24.536=A0 14.433
> -63=A0=A0=A0=A0 26.0=A0=A0 39.0=A0=A0 15.563=A0 8.666
> -42=A0=A0=A0=A0 65.0=A0=A0 58.5=A0=A0 31.218=A0 21.666=A0 20.583
> -60=A0=A0=A0=A0 39.0=A0=A0 26.0=A0=A0 20.49=A0=A0 13.0=A0=A0=A0 10.833
> -63=A0=A0=A0=A0 28.9=A0=A0 58.5=A0=A0 17.852=A0 9.633

Cases where the rx/tx estimate would be higher are marked with !!!.

Why bother and look at rx at all? Asymmetric routing should already
work. I was bit concerned about highly asymmetric links, especially
those where the path back might not work. It might not be worth it though.

Anyway, there are significant over-simplifications in here:
- Is what I see here even representative / does it apply universally?
- Is 5Ghz and 2.4GHz and their modes even comparable like this? Across
drivers/chips?

Regards,
=A0 Ren=E9
> +               if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
> +                       tx =3D cfg80211_calculate_bitrate(&sinfo.txrate);
> +                       if (sinfo.filled & BIT(NL80211_STA_INFO_RX_BITRAT=
E)) {
> +                               rx =3D=20
> cfg80211_calculate_bitrate(&sinfo.rxrate);
> +                               if (rx < tx) {
> +                                       return (rx + tx) / 6;
> +                               }
> +                       }
> +                       return tx / 3;
> +               }
>
> Thanks,
> Marek
