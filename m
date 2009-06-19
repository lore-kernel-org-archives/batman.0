Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 19 Jun 2009 19:50:54 +0800
References: <5161afcd0906181142o4c85ef5dr85fa1c2f54376fc7@mail.gmail.com>
In-Reply-To: <5161afcd0906181142o4c85ef5dr85fa1c2f54376fc7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200906191950.54769.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] opkg doesn't rmmod
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Friday 19 June 2009 02:42:54 Jacob Marble wrote:
> When I "opkg remove kmod-batman-adv-kernelland", the kernel module
> stays loaded, so when I "opkg install kmod-batman-adv-[newer version]"
> the old module stays loaded.  A simple rmmod gets rid of the old
> module.

I thought of that more as a feature as it allows over the mesh updates. If I 
the module gets removed while running an update over the mesh you might render 
your node unusable. On the other hand you can reboot the node after the update 
was completed to have a consistent system. 


> There is a script in the openwrt SVN called postinst that inserts the
> module after install.  Very convenient.  A similar script could be
> added, called prerm, that would remove the module before removing the
> ipk.  There are several ways to rmmod; "rmmod -f batman-adv" might be
> best for removing the package.
>
> When I create the file in my build_dir, make just deletes it, so I
> leave this up to someone else (Marek?).

You have to place the script into the corresponding package folder (batman-adv 
in this case) to avoid deletion. For OpenWRT the package directory is the 
source (nothing will be deleted there) and build_dir is the build path.

If you agree to the point mentioned above I still could add your script but 
keep it deactivated, so that other people can find it. May be someone has an 
idea how to keep everyone happy.  :-)  

Regards,
Marek

