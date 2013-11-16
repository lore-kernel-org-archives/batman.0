Return-Path: <martin@hundeboll.net>
Message-ID: <5287431F.2000205@hundeboll.net>
Date: Sat, 16 Nov 2013 11:04:15 +0100
From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-3-git-send-email-antonio@meshcoding.com>
 <6858187.HqJ4FjDvbE@diderot> <20131116091108.GJ1663@neomailbox.net>
In-Reply-To: <20131116091108.GJ1663@neomailbox.net>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/6] batman-adv: mark a local client as
 isolated when needed
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

On 2013-11-16 10:11, Antonio Quartulli wrote:
> On Sat, Nov 16, 2013 at 01:31:11PM +0800, Marek Lindner wrote:
>> On Wednesday 13 November 2013 17:38:01 Antonio Quartulli wrote:
>>> @@ -474,7 +474,7 @@ static void batadv_tt_global_free(struct batadv_priv
>>> *bat_priv, * Returns true if the client was successfully added, false
>>> otherwise. */
>>>   bool batadv_tt_local_add(struct net_device *soft_iface, const uint8_t
>>> *addr, -                        unsigned short vid, int ifindex)
>>> +                        unsigned short vid, int ifindex, uint32_t mark)
>>>   {
>>>          struct batadv_priv *bat_priv = netdev_priv(soft_iface);
>>>          struct batadv_tt_local_entry *tt_local;
>>
>> Kernel doc ?
>
> argh, I tried to escape the kerneldoc tradition :D

We should make a patch to checkpatch to check for kerneldoc :)

-- 
Kind Regards
Martin Hundebøll
Frederiks Allé 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
