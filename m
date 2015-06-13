Return-Path: <ufo@rund.freifunk.net>
Message-ID: <557C6B3A.4020305@rund.freifunk.net>
Date: Sat, 13 Jun 2015 19:41:14 +0200
From: Ufo <ufo@rund.freifunk.net>
MIME-Version: 1.0
References: <557C4EF0.3060204@rund.freifunk.net> <5848467.YBQmR7qBth@voltaire>
In-Reply-To: <5848467.YBQmR7qBth@voltaire>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] openwrt config changes when upgrading from
 2014-4 to 2015-0 ?
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

ok, my '10 days older openwrt trunk' with batman-adv 2015.0 (compiled
via sdk) is running without bridge-problems.
so batman-adv is not the guilty one

Am 13.06.15 um 18:21 schrieb Marek Lindner:
> On Saturday, June 13, 2015 17:40:32 Ufo wrote:
>> thank you for upgrading batman-adv inside openwrt trunk to
>> 2015-0
>> 
>> im testing new version (yesterdays openwrt trunk) but have
>> problems: the bridge (br-mesh12) with bat-interface and wifi-vAP
>> isnt complete, the bat-interface is missing the "wifi" command
>> also doesnt repair that
>> 
>> but, when i delete vlan-setting (for interface, where batman-adv
>> is running on) problems are gone.
>> 
>> maybe config for openwrt/batman-adv has changed, or some of our
>> settings are outdated and now obsolete?
>> 
>> ufo
>> 
>> p.s. with 10 days old openwrt trunk (and batman-adv 2014-4) the
>> problem doesnt appear
> 
> The batman-adv uci config has not changed one bit. You can check
> the package diff:
> https://github.com/openwrt-routing/packages/commit/4dc2c500ffde0e248dbc83e5bd904ec0c9af0c42
>
>  Can you try the '10 days older openwrt trunk' with batman-adv
> 2015.0 ? That way you can rule out batman-adv.
> 
> Cheers, Marek
> 


-- 
---
Freifunk Leipzig http://leipzig.freifunk.net
