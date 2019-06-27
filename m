Return-Path: <klukonin@gmail.com>
MIME-Version: 1.0
References: <20190609101922.2366-1-treffer@measite.de>
 <3147211.nMDzSnZuI7@rousseau>
 <CALYz8yoj0E1MDoh7ztThK_q_ew0EHa=2vbuwxQFNwUfDvsEGiA@mail.gmail.com>
 <2561263.F3lYGfnSHf@rousseau>
In-Reply-To: <2561263.F3lYGfnSHf@rousseau>
From: =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= <klukonin@gmail.com>
Date: Thu, 27 Jun 2019 15:41:54 +0500
Message-ID: <CALYz8ypn2fQYCxbFDCbUmAgYHcHaxzPgGWkQPAhz2qxy3Qu-RA@mail.gmail.com>
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

Hello, Marek.

On Thursday, 13 June 2019 04:50:44 HKT =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=BB=
 =D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
>> So here is the algorithm. It has a structure we call matryoshka.
>> ET - Expected_throughput.
>>
>> 1) ET =3D TX_bitrate * Transmit_probability * Overhead_coefficient
>> Transmit_probability is always less than 1 so Expected throughput
>> can't be equal to the TX_bitrate. Overhead_coefficient is also should
>> be less than 1
>>
>> 2) Transmit_probability =3D 1 - Retry_probability - Error_probability
>>
>> 3) Retry_probability =3D TX_retries / TX_packets
>>
>> 4) Error_probability =3D TX_errors / TX_packets
>>
>> 5) Overhead_coefficient for 802.11 is fair enough to be 0.65, but can
>> be changed after additional testing.
>>
>>
>> ET =3D TX_bitrate * (1 - (TX_retries + TX_errors) / TX_packets) * 0.65
>> Such technique has very large hysteresis which is good to avoid
>> flapping between different nodes.
>> In my MESH lab this formula works quite well.

>This looks like an interesting approach. Which chips / environments did yo=
u
>test this formula with and how did the result compare to the actual TCP
>throughput ?

>Thanks,
>Marek


Mostly QCA988x was tested.
Sorry, I lost my test results so I need to do it again.
I have UBNT AC MESH, UBNT AP AC Lite and TP-Link RE450 in my lab.

Also, as I think, it's better to test UDP throughput, But I can test
both TCP and UDP.
This formula always show a result that close to UDP throughput. So,
may be we can think about additional parameters/coefficients that
depend on protocols or something else.



Best Regards,
Lukonin Kirill

=D0=B2=D1=82, 25 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 13:26, Marek Lindn=
er <mareklindner@neomailbox.ch>:
>
> On Thursday, 13 June 2019 04:50:44 HKT =D0=9A=D0=B8=D1=80=D0=B8=D0=BB=D0=
=BB =D0=9B=D1=83=D0=BA=D0=BE=D0=BD=D0=B8=D0=BD wrote:
> > So here is the algorithm. It has a structure we call matryoshka.
> > ET - Expected_throughput.
> >
> > 1) ET =3D TX_bitrate * Transmit_probability * Overhead_coefficient
> > Transmit_probability is always less than 1 so Expected throughput
> > can't be equal to the TX_bitrate. Overhead_coefficient is also should
> > be less than 1
> >
> > 2) Transmit_probability =3D 1 - Retry_probability - Error_probability
> >
> > 3) Retry_probability =3D TX_retries / TX_packets
> >
> > 4) Error_probability =3D TX_errors / TX_packets
> >
> > 5) Overhead_coefficient for 802.11 is fair enough to be 0.65, but can
> > be changed after additional testing.
> >
> >
> > ET =3D TX_bitrate * (1 - (TX_retries + TX_errors) / TX_packets) * 0.65
> > Such technique has very large hysteresis which is good to avoid
> > flapping between different nodes.
> > In my MESH lab this formula works quite well.
>
> This looks like an interesting approach. Which chips / environments did y=
ou
> test this formula with and how did the result compare to the actual TCP
> throughput ?
>
> Thanks,
> Marek
>
