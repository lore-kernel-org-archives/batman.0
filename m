Return-Path: <contact@wifibot.com>
References: <572DF6E3.3030901@wifibot.com> <1884294.h0rzVsQuVd@sven-edge>
 <572E1ADE.5040400@wifibot.com> <1916326.J0HcRb74sF@sven-edge>
From: contact <contact@wifibot.com>
Message-ID: <572E1D1C.7010505@wifibot.com>
Date: Sat, 7 May 2016 18:51:40 +0200
MIME-Version: 1.0
In-Reply-To: <1916326.J0HcRb74sF@sven-edge>
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

yes it is in the routing feed I did not change anything from the openwrt 
files.

Ok, so you suggest to use the devel feed with thye last commit ?

Regards,

Laurent

On 07/05/2016 18:44, Sven Eckelmann wrote:
> On Saturday 07 May 2016 18:42:06 contact wrote:
>> it was the default version present in yesterday openwrt stable 15.05.1
>>
>> in batman makefile i have :
>>
>> include $(TOPDIR)/rules.mk
>>
>> PKG_NAME:=batman-adv
>>
>> PKG_VERSION:=2016.1
>> PKG_RELEASE:=1
>> PKG_MD5SUM:=8c8e449009b4d29512d26ee308960bb5
> This doesn't say much (and you most likely meant openwrt-routing because
> openwrt itself doesn't provide batman-adv). But and Marek fixed a crash since
> yesterday. Not sure if it is related.
>
> Kind regards,
> 	Sven

