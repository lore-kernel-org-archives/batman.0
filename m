Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
MIME-Version: 1.0
From: Mark Birss <markbirss@gmail.com>
Date: Wed, 24 Jun 2020 23:13:50 +0200
Message-ID: <CADg1mwL07UQqmUctQexAFCgFMrXBiF=rB1EdRqb3agveSEkckQ@mail.gmail.com>
Subject: BATMAN-adv Debug options
Content-Type: text/plain; charset="UTF-8"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi All

I just recently been using BATMAN-adv over ethernet

What other debug  information are available to troubleshoot connection issues?


I have enabled for OpenWRT
echo "CONFIG_BATMAN_ADV_DEBUG=y" >> .config
echo "CONFIG_BATMAN_ADV_DEBUGFS=y" >> .config
echo "CONFIG_BATMAN_ADV_BLA=y" >> .config
echo "CONFIG_BATMAN_ADV_DAT=y" >> .config
echo "CONFIG_BATMAN_ADV_MCAST=y" >> .config
echo "CONFIG_BATMAN_ADV_NC=n" >> .config
echo "CONFIG_BATMAN_ADV_BATMAN_V=y" >> .config
echo "CONFIG_BATMAN_ADV_SYSFS=y" >> .config
echo "CONFIG_BATMAN_ADV_TRACING=y" >> .config


echo 255 > /sys/class/net/bat0/mesh/log_level
cat /sys/kernel/debug/batman_adv/bat0/log


since i want to understand also why on wifi mesh seems to crash for me ath10k


Regards
