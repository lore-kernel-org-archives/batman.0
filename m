Return-Path: <gui@altermundi.net>
Message-ID: <525F9533.8040504@altermundi.net>
Date: Thu, 17 Oct 2013 09:43:47 +0200
From: Gui Iribarren <gui@altermundi.net>
MIME-Version: 1.0
References: <525B189E.1080105@altermundi.net>
 <201310141952.34222.sw@simonwunderlich.de>
In-Reply-To: <201310141952.34222.sw@simonwunderlich.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] alfred: Bundle a lua script for
 autogenerating bat-hosts file
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
To: Simon Wunderlich <sw@simonwunderlich.de>, b.a.t.m.a.n@lists.open-mesh.org

On 10/14/2013 07:52 PM, Simon Wunderlich wrote:
>
>> Provide a lua script that uses alfred to propagate and collect all
>> interface mac + names, then generate a /tmp/bat-hosts file.
>> If there's already a (probably hand-made) /etc/bat-hosts it won't overwrite
>> it but if there's none, it will symlink /etc/bat-hosts -> /tmp/bat-hosts
>>
>> Signed-off-by: Gui Iribarren <gui@altermundi.net>
>> Thanks-to: Joshua Head <joshua.head@outlook.com>
>
> Thanks a lot, this sounds like a really good idea! As this will be part of the
> openwrt package, I'd like to ask to make the bat-hosts.lua script optional and
> selectable (like you can turn on/off vis). I'll do the same for other
> (optional) services like gps.
>
> Also, do you need any additional dependencies for lua?

not that i know of; an early version depended on nixio lib, but Joshua 
Head from vt-dev refactored the relevant functions and dropped that dep :)

