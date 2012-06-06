Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAFnqJHGU6SpApnvO3eJYq6ABAAAAAA==@gmail.com>
References: <!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAPvMiqao58dPrVwIXxeghf4BAAAAAA==@gmail.com>
	<1794568.t7tZJ9NAC6@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAF6fjKGT24hLtxfi+jpGMQMBAAAAAA==@gmail.com>
	<6725381.buXcpkeOMp@bentobox>
	<!&!AAAAAAAAAAAYAAAAAAAAAOJK0u4CH31Kl5v1RPAzyrZCgQAAEAAAAFnqJHGU6SpApnvO3eJYq6ABAAAAAA==@gmail.com>
Date: Wed, 6 Jun 2012 15:04:56 +0200
Message-ID: <CAKeC-QHoAPj5aVCm1WF6kHC2oAJNjmcMvQ_a_-tnYQNSnmgx2g@mail.gmail.com>
From: Wayne Abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] bridging problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Jun 6, 2012 at 2:59 PM, Walter Robert Ditzler
<ditwal001@gmail.com> wrote:
> sven,
>
> root@srv-ldeb-basic1:/etc/hostapd# ifconfig wlan0 down hw ether
> 02:34:56:78:9a:bc up
> SIOCSIFFLAGS: Link number out of range
> root@srv-ldeb-basic1:/etc/hostapd#
>
> cheers walter
>
>
>
> -----Original Message-----
> From: Sven Eckelmann [mailto:sven@narfation.org]
> Sent: Mittwoch, 6. Juni 2012 14:38
> To: Walter Robert Ditzler
> Cc: 'Antonio Quartulli'; b.a.t.m.a.n@lists.open-mesh.org
> Subject: Re: [B.A.T.M.A.N.] bridging problem
>
> On Wednesday 06 June 2012 14:26:12 Walter Robert Ditzler wrote:
>>
>> (with nl80211)
>> ***
>> root@srv-ldeb-basic1:/etc/hostapd# hostapd hostapd.conf Configuration
>> file: hostapd.conf
>> ioctl[SIOCSIFFLAGS]: Name not unique on network
>> nl80211 driver initialization failed.
>> ELOOP: remaining socket: sock=3D5 eloop_data=3D0x9141a30 user_data=3D(ni=
l)
>> handler=3D0x80863e0
>> root@srv-ldeb-basic1:/etc/hostapd#
>> ***
>
>
> You must make sure that each Vif/VAP device has a different mac address.
>
> sudo ifconfig wlan0 down hw ether 02:34:56:78:9a:bc up
>
> Kind regards,
> =A0 =A0 =A0 =A0Sven

Hi Walter

Is it possible to run two drivers at the same time on hostapd?

driver=3Dnl80211 / madwifi

Should be one or the other IIRC.

Wayne
