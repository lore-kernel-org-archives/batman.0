Return-Path: <gui@altermundi.net>
Message-ID: <51F5C2ED.3010207@altermundi.net>
Date: Sun, 28 Jul 2013 22:18:37 -0300
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <51F5B134.4030203@altermundi.net> <51F5B9AF.9020909@wirelesspt.net>
In-Reply-To: <51F5B9AF.9020909@wirelesspt.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Complete netifd integration in openwrt
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
To: cmsv@wirelesspt.net
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On 07/28/2013 09:39 PM, cmsv wrote:
> Is this change going to be in efect with current openwrt AA and
> batman-adv 2013.3.0 or still optional ?

Aw, sorry for the confusion, bad timing :(
batman-adv 2013.3.0 is already released, and this particular patch is 
still a pull request , so: no, this is still just an idea.
batman-adv 2013.3.0 has no config style changes AFAIK

>> # cat /etc/config/network
>> config interface 'bat0'
>>      option proto 'batmesh'
>>      option ifname 'bat0'
>>      option ap_isolation '1'
>>      option gw_mode 'server'
>>
>> config interface 'mesh0'
>>      option ifname 'eth2'
>>      option proto 'batadv'
>>      option mesh 'bat0'
>
> also valid for all previous /etc/config/batman-adv available options  or
> just the ones you wrote here?

Yes, all available options as of today. This was just a short example :)

