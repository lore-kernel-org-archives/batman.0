Return-Path: <bigeasy@linutronix.de>
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next 00/10] net: Convert user to netif_rx(), part 3.
Date: Sun,  6 Mar 2022 22:57:43 +0100
Message-Id: <20220306215753.3156276-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Alexander Gordeev <agordeev@linux.ibm.com>, Alexandra Winter <wintera@linux.ibm.com>, Andrew Lunn <andrew@lunn.ch>, Antonio Quartulli <a@unstable.cc>, b.a.t.m.a.n@lists.open-mesh.org, Christian Borntraeger <borntraeger@linux.ibm.com>, Divya Koppera <Divya.Koppera@microchip.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heiko Carstens <hca@linux.ibm.com>, Heiner Kallweit <hkallweit1@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, Jon Maloy <jmaloy@redhat.com>, linux-bluetooth@vger.kernel.org, linux-s390@vger.kernel.org, linux-staging@lists.linux.dev, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Marek Lindner <mareklindner@neomailbox.ch>, Remi Denis-Courmont <courmisch@gmail.com>, Russell King <linux@armlinux.org.uk>, Simon Wunderlich <sw@simonwunderlich.de>, Sven Eckelmann <sven@narfation.org>, Sven Schnelle <svens@linux.ibm.com>, tipc-discussion@lists.sourceforge.net, Vasily Gorbik <gor@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Ying Xue <ying.xue@windriver.com>

This is the third and last batch of converting netif_rx_ni() caller to
netif_rx(). The change making this possible is net-next and
netif_rx_ni() is a wrapper around netif_rx(). This is a clean up in
order to remove netif_rx_ni().

The micrel phy driver is patched twice within this series: the first is
is to replace netif_rx_ni() and second to move netif_rx() outside of the
IRQ-off section. It is probably simpler to keep it within this series.

Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Divya Koppera <Divya.Koppera@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Jon Maloy <jmaloy@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
Cc: linux-s390@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Cc: Remi Denis-Courmont <courmisch@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Cc: Sven Eckelmann <sven@narfation.org>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: tipc-discussion@lists.sourceforge.net
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: Ying Xue <ying.xue@windriver.com>

Sebastian


