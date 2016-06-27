Return-Path: <sailashm@gmail.com>
MIME-Version: 1.0
In-Reply-To: <15442021.aXYrkMLT6N@sven-edge>
References: <CAM3k=84krmoLaW2X59VujDb_ZxuMJW-6pwGDhDLx=0-HHG6O=Q@mail.gmail.com>
 <24448293.C3avDh6gQR@sven-edge>
 <0F40DD26-09F6-4ED6-B0BC-7413FF5ED713@gmail.com>
 <15442021.aXYrkMLT6N@sven-edge>
From: Sailash Moirangthem <sailashm@gmail.com>
Date: Mon, 27 Jun 2016 12:58:24 +0530
Message-ID: <CAM3k=86OU_+ZX8TqiBrLAqe446Z1YNGpD7WtH+BxPanrksjoAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Adhoc0 Interface not showing up
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Sven,
This question may sound dumb. But I need your help in this please. I
upgraded my openwrt to the latest version 15.05. I then tried
installing kmod-batman-adv. It gave me error:

satisfy_dependencies_for: Cannot satisfy the following dependencies
for kmod-batman-adv:
kernel (= 3.18.14-1-406f55e08cbd4433be5683443e405921) *

I followed the following steps:
1 . Note: If you downloaded an Openwrt release but intend to build the
latest batman-adv package you might need to modify your
feeds.conf(.default). Make sure you have "src-git routing
git://github.com/openwrt-routing/packages.git" instead of e.g.
"src-git routing
git://github.com/openwrt-routing/packages.git;for-12.09.x".

This doesnt seem to work. Can you please tell me the steps on how to
install the latest batman-adv in my 15.05 openwrt firmware. Thanks a
ton.

Thanks,
Sailash M

On Sat, Jun 25, 2016 at 11:04 AM, Sven Eckelmann <sven@narfation.org> wrote:
> On Saturday 25 June 2016 10:04:41 sailashm@gmail.com wrote:
>> Hi Sven,
>>
>> I will give it a shot on monday and let you know. However, when using the
> BATMAN-adv in my 5 tplink routers, the AP interface keeps disconnecting and is
> not stable. The version of batman-adv is 14. Is this version of batman-adv
> unstable?
>
> batman-adv with the COMPAT_VERSION 14 (used in v2011.3.0 <= batman-adv <
> v2014.0.0) is either really old and unsupported (it has known problems which
> fill not be fixed by us anymore).... or you are using batman-adv-legacy [1]
> from Matthias Schiffer. If the latter is the case then please upgrade to the
> latest version from him, test again and then contact him when you need support
> for this version.
>
> But to be honest, batman-adv is not managing the AP interface and thus it
> should have no influence on the AP interface authentication/deauthentication
> behavior or the AP interface state.
>
> Kind regards,
>         Sven
>
> [1] https://github.com/freifunk-gluon/batman-adv-legacy
