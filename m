Return-Path: <martin@hundeboll.net>
References: <CANC9+Di3GnouTrYDsp0ihbAFAV9xahr9T88KdqTBuK_nV6xUGw@mail.gmail.com>
 <CANC9+Djjuo3pvuwAUfFmPCM8KAxDXro8SeubMrdy9QB4ewgTjg@mail.gmail.com>
From: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@hundeboll.net>
Message-ID: <5639EA30.6010403@hundeboll.net>
Date: Wed, 4 Nov 2015 12:21:20 +0100
MIME-Version: 1.0
In-Reply-To: <CANC9+Djjuo3pvuwAUfFmPCM8KAxDXro8SeubMrdy9QB4ewgTjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Fwd: MTU problem
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Abejaro <aabejaro@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Antonio,

Please direct your mails to the batman mailing list:
b.a.t.m.a.n@lists.open-mesh.org

This way, others can help you too.

On 2015-11-04 12:15, Antonio Abejaro wrote:
> I have just configured the value of 1532 for MTU in /etc/config/network
> as suggested but when I reboot my node I obtain the following dmesg:
>
> batman_adv: bat0: The MTU of interface adhoc0 is too small (1500) to
> handle the transport of batman-adv packets. Packets going over this
> interface will be fragmented on layer2 which could impact the
> performance. Setting the MTU to 1532 would solve the problem.

What version of b.a.t.m.a.n. are you using? We had an issue in earlier 
version, where the suggested value was too small...

// Martin
