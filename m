Return-Path: <plettpc@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACUGKYOvkhxWzR4SxAkX33Gsz6AK0cY6HZLjOjn5n5BNevPahw@mail.gmail.com>
References: <CACUGKYOvkhxWzR4SxAkX33Gsz6AK0cY6HZLjOjn5n5BNevPahw@mail.gmail.com>
Date: Wed, 17 Aug 2011 08:20:24 +0200
Message-ID: <CAKeC-QEO8AqD=Jzqr_OuAWAf6cUqNE5--fhs-NMpTGmnsp7m1g@mail.gmail.com>
From: wayne abroue <plettpc@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Configuring batman
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

On Wed, Aug 17, 2011 at 4:10 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Guys,
>
> I have two devices, both of them have eth0, wlan0. I followed the
> BATMAN quick start guide
> (http://www.open-mesh.org/wiki/batman-adv/Quick-start-guide) mixing
> non-BATMAN.
> The bat0, eth0, wlan0 on both devices were set to 0.0.0.0 and the
> mesh-bridge on dev1 was set to 192.168.10.1 and on dev2 was set to
> 192.168.10.2. Both devices can ping to each other.
>
> When I execute "batctl gwl", I was getting "No gateways in range ...".
>
> My question is, do you have a sample step-by-step procedures to bring
> up the batman correctly?.
>
> Regards,
>
> john
>

Hi John

Firstly , what makes you think Batman is not up correctly?
Then, I'm sure we can make more sense of your problem if you explain
your network, you talk about two devices, that can ping each other,
The simplest, is Bat0 which runs on Wlan0, So configure bridge on only
Eth0 and bat0, thus anything on eth0, will see bat0(AKA, batman
network) transparently.
No need for GW. If clients get DHCP from anywhere, they should get the
gateway details.

Wayne A
