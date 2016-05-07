Return-Path: <contact@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <1916326.J0HcRb74sF@sven-edge>
 <572E1D1C.7010505@wifibot.com> <18515809.rdrhCmqhC3@voltaire>
From: contact <contact@wifibot.com>
Message-ID: <572E1EE2.3060806@wifibot.com>
Date: Sat, 7 May 2016 18:59:14 +0200
MIME-Version: 1.0
In-Reply-To: <18515809.rdrhCmqhC3@voltaire>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] no able to switch routing algo to V ?
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

I just updated I need to recompile and re-flash my nodes it takes 
sometime, can you check please if all your patches are here ?

user@ubuntuvm:~/openwrt15011/openwrt/scripts$ ./feeds update
Updating feed 'packages' from 
'https://github.com/openwrt/packages.git;for-15.05' ...
Already up-to-date.
Create index file './feeds/packages.index'
Updating feed 'luci' from 
'https://github.com/openwrt/luci.git;for-15.05' ...
Already up-to-date.
Create index file './feeds/luci.index'
Updating feed 'routing' from 
'https://github.com/openwrt-routing/packages.git;for-15.05' ...
remote: Counting objects: 10, done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 10 (delta 2), reused 10 (delta 2), pack-reused 0
Unpacking objects: 100% (10/10), done.
 From https://github.com/openwrt-routing/packages
    16ceff2..a3cd8a1  for-15.05  -> origin/for-15.05
Updating 16ceff2..a3cd8a1
Fast-forward
  ...make-sure-ELP-OGM-orig-MAC-is-updated-on-.patch |  64 ++++++++++++
  ...-adv-Avoid-duplicate-neigh_node-additions.patch |  89 +++++++++++++++++
  ...Avoid-nullptr-derefence-in-batadv_v_neigh.patch |  38 +++++++
  ...an-adv-Fix-refcnt-leak-in-batadv_v_neigh_.patch |  81 +++++++++++++++
  ...Fix-double-neigh_node_put-in-batadv_v_ogm.patch |  40 ++++++++
  ...initialize-ELP-orig-address-on-secondary-.patch | 110 
+++++++++++++++++++++
  6 files changed, 422 insertions(+)
  create mode 100644 
batman-adv/patches/0001-batman-adv-make-sure-ELP-OGM-orig-MAC-is-updated-on-.patch
  create mode 100644 
batman-adv/patches/0002-batman-adv-Avoid-duplicate-neigh_node-additions.patch
  create mode 100644 
batman-adv/patches/0003-batman-adv-Avoid-nullptr-derefence-in-batadv_v_neigh.patch
  create mode 100644 
batman-adv/patches/0004-batman-adv-Fix-refcnt-leak-in-batadv_v_neigh_.patch
  create mode 100644 
batman-adv/patches/0005-batman-adv-Fix-double-neigh_node_put-in-batadv_v_ogm.patch
  create mode 100644 
batman-adv/patches/0006-batman-adv-initialize-ELP-orig-address-on-secondary-.patch
Create index file './feeds/routing.index'
Updating feed 'telephony' from 
'https://github.com/openwrt/telephony.git;for-15.05' ...
Already up-to-date.
Create index file './feeds/telephony.index'
Updating feed 'management' from 
'https://github.com/openwrt-management/packages.git;for-15.05' ...
Already up-to-date.
Create index file './feeds/management.index'


On 07/05/2016 18:53, Marek Lindner wrote:
> On Saturday, May 07, 2016 18:51:40 contact wrote:
>> yes it is in the routing feed I did not change anything from the openwrt
>> files.
>>
>> Ok, so you suggest to use the devel feed with thye last commit ?
> Please update your routing feed first. I pushed several stability updates
> today.
>
> Thanks,
> Marek

