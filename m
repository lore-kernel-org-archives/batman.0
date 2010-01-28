Return-Path: <alx@dd19.de>
Message-Id: <0BAEFC67-49C9-4147-AEE1-83208A37DE1E@dd19.de>
From: Alex Morlang <alx@dd19.de>
In-Reply-To: <4B61351A.5030605@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Thu, 28 Jan 2010 15:52:56 +0100
References: <5522db2e1001261326g7068972fq9c82780bcf5dc99e@mail.gmail.com>
	<4B61351A.5030605@gmail.com>
Subject: Re: [B.A.T.M.A.N.] batman-adv and IPSec
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


Am 28.01.2010 um 07:56 schrieb Gus Wirth:

> On 01/26/2010 01:26 PM, ecfu wrote:
>> Can I use IPSec with batman-adv?  Has anyone ever done this?  Is  
>> there
>> anything special that needs to be done or because I am using batman- 
>> adv,
>> this is transparent?
>
> IPSec is basically IP inside IP. Since batman-adv works on the layer 2
> level (ethernet frames) you shouldn't have to worry about. It should
> "Just Work"

ipsec is basically much more the ip inside ip.

you are refering to ipsec-tunnel.

see also http://tools.ietf.org/html/rfc2406

>
> Gus

alx
