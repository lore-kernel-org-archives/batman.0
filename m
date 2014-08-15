Return-Path: <liudows@aliyun.com>
Message-ID: <53EDA50D.4030602@aliyun.com>
Date: Fri, 15 Aug 2014 14:13:33 +0800
From: liu <liudows@aliyun.com>
MIME-Version: 1.0
References: <53EC5D49.5000705@aliyun.com> <53EC7E6C.7000900@aliyun.com>
 <3486850.VCLybl6GSa@diderot>
In-Reply-To: <3486850.VCLybl6GSa@diderot>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] how to compile the latest version of batctl in
 OpenWrt 12.09
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Yes, I have tried. On a OpenWrt 12.09 with kernel 3.3.8, 
batman.adv-2014.3 CAN NOT creates a 'bat0' interface.
You know, kernel '3.3.8' is a rather old kernel version, and '2014.3' is 
the latest batman.adv version.

Besides,  I want to know that from which version the feature of non-mesh 
client roaming is available?

Thanks.

Best regards,
Liu


On 2014/8/15 13:13, Marek Lindner wrote:
> On Thursday 14 August 2014 17:16:28 liu wrote:
>> Now I switch to version '2013.4.0' of batman-adv.But when I run this
>> command 'batctl if add wlan0-1', the system crash. And it works well in
>> version '2012.3.0'. I want to know which version is suitable for OpenWrt
>> 12.09?
> We don't track which OpenWrt versions work with batman-adv. Technically, you
> have to check for kernel compatibilities. If the kernel is newer than batman-
> adv it probably won't work. Newer batman-adv on older kernel has a good chance
> of success.
>
> Cheers,
> Marek

