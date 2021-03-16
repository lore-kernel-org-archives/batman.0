Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Tue, 16 Mar 2021 18:29:12 +0100
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: batman-adv for kbit level speeds, external neighbor info
Message-ID: <20210316172912.GB2292@otheros>
References: <20210316131750.1198.63671@diktynna.open-mesh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316131750.1198.63671@diktynna.open-mesh.org>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: oytunyapar@hotmail.com

On Tue, Mar 16, 2021 at 01:17:50PM -0000, oytunyapar@hotmail.com wrote:
> Hi everybody,
> 
>     I have some questions about batman-adv.
>     Do you suggest, batman-adv, for speeds like 2.4kbit/s (very slow networks)? I tried to use batctl throughput_override, for such a setup. It seems at least 100kbit/s speed is valid for this utility.
>     Is there any way, feeding neighbor information to batman-adv externally (etc. using DLEP protocol, as an external link monitor)?
>     Thank you in advance.

If you use throughput override on all devices, you could also
just shift the value equally on all devices. For instance just set
24 Mbit/s instead for a 2.4 kbit/s link.

BATMAN V algorithm itself at the moment does not care about the
actual accuracy of the unit. As long as the values are not too
small or too large. And as long as it's the same baseline on all
devices.

Regards, Linus
