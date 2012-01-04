Return-Path: <roblourens@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201201050057.03301.lindner_marek@yahoo.de>
References: <CAAXbfMH0OmQhWja_1sjYRzkyS4x-SGu8h7uQdye6iKRTkyLt5w@mail.gmail.com>
	<201201050057.03301.lindner_marek@yahoo.de>
From: Rob Lourens <roblourens@gmail.com>
Date: Wed, 4 Jan 2012 11:06:49 -0600
Message-ID: <CAAXbfMGaGzb01nSEZ6ypBdOFsevZgUNuVngMn+1AeGq6riKCug@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Loading the kernel module
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

You're right, I realized I'm using the version from the Ubuntu
repositories, which is .2, and not the current version.

Thanks!

On Wed, Jan 4, 2012 at 10:57 AM, Marek Lindner <lindner_marek@yahoo.de> wrote:
>
> Hi,
>
>> I'm having trouble with loading the kernel module. I'm sure it's just
>> a dumb mistake on my part. I compiled the module, loaded it with
>> insmod, and I can add interfaces using
>> /sys/class/net/wlan0/batman_adv, but batctl says that the kernel
>> module may not be loaded. It's true that there is no folder
>> /proc/net/batman-adv.
>
> seems your batctl is way outdated. What batctl version do you have ? Simply
> run "batctl -v". Before the restructuring 2 years ago the interface
> configuration happened in /proc/net/batman-adv.
>
> Regards,
> Marek
