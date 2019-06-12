Return-Path: <klukonin@gmail.com>
MIME-Version: 1.0
References: <20190609101922.2366-1-treffer@measite.de>
 <4907494.lMUJSmCnaO@rousseau>
 <CALYz8yoqh8X3hZcafrZAauFT4OZtQZ9r92G+9zW9__ir4m5How@mail.gmail.com>
 <3147211.nMDzSnZuI7@rousseau>
In-Reply-To: <3147211.nMDzSnZuI7@rousseau>
From: =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>
Date: Thu, 13 Jun 2019 01:50:44 +0500
Message-ID: <CALYz8yoj0E1MDoh7ztThK_q_ew0EHa=2vbuwxQFNwUfDvsEGiA@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: Use wifi rx/tx as fallback throughput
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Marek Lindner <mareklindner@neomailbox.ch>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

=D1=81=D1=80, 12 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 11:39, Marek Lindn=
er <mareklindner@neomailbox.ch>:
>
> Hi,
>
> > I have a working solution for this problem. It is not batman-related,
> > but I decided to share it with you right here.
> > Please let me clarify some  details.
> >
> > 1) Some ath10k firmwares (10.2) do not export tx bitrate. So we can't
> > rely on it.
> > 2) Throughput estimation is better to inject from userspace, rather
> > than make batman estimate it from unreliable sources.
> > 3) Here is the patch for mac80211 We made for ath10k and such drivers
> > that do not export expected throughput value.
>
> you are very right about those issues. However, your patch only provides =
a
> quick way to push an arbitrary throughput metric into the batman-adv kern=
el
> module. The current discussion is about how such metric could be best der=
ived
> in an automated fashion.
>
> Would you mind sharing your approach to obtaining such a metric that addr=
esses
> the problems mentioned above ?
>
> Thanks,
> Marek
>

Yes, sure.

I can't share a source code because it partially belongs to one
commercial company.
But I want and I can share my ideas with empirical evidence.
Also I will be very glad to help Batman-avd mesh community and become
a part of it.

So here is the algorithm. It has a structure we call matryoshka.
ET - Expected_throughput.

1) ET =3D TX_bitrate * Transmit_probability * Overhead_coefficient
Transmit_probability is always less than 1 so Expected throughput
can't be equal to the TX_bitrate. Overhead_coefficient is also should
be less than 1

2) Transmit_probability =3D 1 - Retry_probability - Error_probability

3) Retry_probability =3D TX_retries / TX_packets

4) Error_probability =3D TX_errors / TX_packets

5) Overhead_coefficient for 802.11 is fair enough to be 0.65, but can
be changed after additional testing.


ET =3D TX_bitrate * (1 - (TX_retries + TX_errors) / TX_packets) * 0.65
Such technique has very large hysteresis which is good to avoid
flapping between different nodes.
In my MESH lab this formula works quite well.
Please ask any questions and feel free to criticize.


Also please note that ath10k tx_bitrate can be fetched from ath10k
firmware debugfs statistics. Even with 10.2 firmware.


Best Regards,
Lukonin Kirill
