Return-Path: <martin@hundeboll.net>
Message-ID: <547C5E2A.2050300@hundeboll.net>
Date: Mon, 01 Dec 2014 13:25:14 +0100
From: =?windows-1252?Q?Martin_Hundeb=F8ll?= <martin@hundeboll.net>
MIME-Version: 1.0
References: <4472936.imSdHEx948@sven-edge>
In-Reply-To: <4472936.imSdHEx948@sven-edge>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Fragmentation and padding in batman-adv
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
Cc: Sven Eckelmann <sven@narfation.org>

Hi Sven,

On 2014-12-01 08:49, Sven Eckelmann wrote:
> Hi,
>
> I've just noticed that the padding by the underlying network protocol seems
> not to be handled by the fragmentation. Maybe Martin can correct me. I will
> now use following assumptions:
>
>   * the fragmentation code is sending first the last part of the packet and
>     tries to fill the complete skb (max 1400 byte)
>   * the mtu of the underlying device is 1400
>   * the minimum packet size (user data + eth header) of the underlying device
>     is 70
>   * the packet send by the user would end up to be 1401 bytes before
>     fragmentation
>
> Ok, then I would guess that the fragmentation code would try to generate
> fragments with the max_fragment_size 1366 (+headers of course, not sure why
> the code assumes that the ethernet header is part of the MTU). This would mean
> that the 1401 byte packet is split into a 1366 byte fragment (+header) and a
> 35 byte fragment (+header).
>
> But the 35 byte fragment containing the first part of the packet is (even with
> the headers) still smaller than the required packet size of the underlying
> device. Now some extra bytes are added as padding to the last fragment
> (containing the first part of the original packet).
>
> The receiving node cannot merge the fragments anymore because the length of
> the last fragment skb will be too large and therefore the
> total_size < chain->size.
>
> Even when it could be merged (because of some bug in the size check) then the
> resulting packet would have a padding byte in the middle of of the original
> byte.
>
> And just in case somebody has something against the imaginary 70 bytes padding
> (802.3 has 60): I had to work with virtual devices in the past which had a
> fixed MTU of ~1400 and a minimum packet size of ~1400.
>
> And yes, I am fully aware of the workaround of using an extra virtual device
> between batman-adv and the actual device which only adds a header with the
> payload length and restores this length on the receiver site. This (or at
> least something similar) was used by me in the other project with the MTU/min
> packet size of ~1400 device.
>
> Any comments, corrections?

Your deduction looks correct to me, and padding wasn't considered when 
developing the fragmentation code.

We can fix this by transmitting the fragments in correct (non-reverse) 
order. This would make the check on total_size fail, and thus we would 
need to try to merge anything with chain->size >= total_size, but only 
merge total_size bytes.

The tx order can be changed without breaking compatibility, as each 
fragment still carries its frag number.

Changing the tx-order might also increase chances that no alloc of 
memory is needed upon merge. Take Sven's example:
1) Currently, the first fragment in the chain is the smallest, and it is 
increased by ~MTU bytes to make room for the other fragment.
2) By changing the order, the first fragment is the largest, and would 
only need to have 35 bytes of tailroom in order to allow a merge without 
allocating memory.

Initially, the reverse tx order was chosen to allow the use of 
skb_split() when creating fragments. This is not strictly needed, so 
changing the order shouldn't be too hard.

// Martin
